/obj/item/weapon/grenade
	name = "граната"
	desc = "Ручная граната с 5-секундным запалом."
	w_class = ITEM_SIZE_SMALL
	icon = 'icons/obj/grenade.dmi'
	icon_state = "grenade_old"
	item_state = "grenade"
	throw_speed = 4
	throw_range = 8
	flags = CONDUCT
	slot_flags = SLOT_BELT|SLOT_POCKET
	var/active = FALSE
	var/det_time = 50
	var/loadable = TRUE
	var/armsound = 'sound/weapons/armbomb.ogg'
	flammable = TRUE
	value = 5
	var/explosion_sound = 'sound/weapons/Explosives/HEGrenade.ogg'
	var/mob/living/human/firer = null
/obj/item/weapon/grenade/examine(mob/user)
	if (..(user, FALSE))
		if (det_time > 1)
			user << "Таймер установлен на [det_time/10] секунд."
			return


/obj/item/weapon/grenade/attack_self(mob/user as mob)
	if (!active)
		user << "<span class='warning'>Активирую [name]! [det_time/10] секунд до взрыва!</span>"
		firer = user
		activate(user)
		add_fingerprint(user)

	// clicking a grenade a second time turned throw mode off, this fixes that
	if (ishuman(user))
		var/mob/living/human/H = user
		if(istype(H) && !H.in_throw_mode)
			H.throw_mode_on()

/obj/item/weapon/grenade/dropped(mob/user)
	. = ..()
	if(ishuman(user) && active)
		var/mob/living/human/H = user
		H.throw_mode_off()

/obj/item/weapon/grenade/proc/activate(mob/living/human/user as mob)
	if (active)
		return

	if (user)
		msg_admin_attack("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)", user.ckey)
		message_admins("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)", user.ckey)
		log_game("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")
		firer = user
	icon_state = initial(icon_state) + "_active"
	active = TRUE
	playsound(loc, armsound, 75, TRUE, -3)

	spawn(det_time)
//		visible_message("<span class = 'warning'>[src] выгорает!</span>")
		prime(user)
		return

/obj/item/weapon/grenade/proc/fast_activate()
	det_time = round(det_time/10)
	activate()

/obj/item/weapon/grenade/proc/prime()
	return

/obj/item/weapon/grenade/attack_hand()
	walk(src, null, null)
	..()
	return

/obj/item/weapon/grenade/proc/damage_hull(var/turf/T)
	for(var/obj/structure/vehicleparts/frame/F in range(1,T))
		for (var/mob/M in F.axis.transporting)
			shake_camera(M, 1, 1)
		var/penloc = F.CheckPenLoc(src)
		switch(penloc)
			if ("left")
				if (F.w_left[5] > 0)
					F.w_left[5] -= heavy_armor_penetration
					visible_message("<span class = 'danger'><big>The left hull gets damaged!</big></span>")
			if ("right")
				if (F.w_right[5] > 0)
					F.w_right[5] -= heavy_armor_penetration
					visible_message("<span class = 'danger'><big>The right hull gets damaged!</big></span>")
			if ("front")
				if (F.w_front[5] > 0)
					F.w_front[5] -= heavy_armor_penetration
					visible_message("<span class = 'danger'><big>The front hull gets damaged!</big></span>")
			if ("back")
				if (F.w_back[5] > 0)
					F.w_back[5] -= heavy_armor_penetration
					visible_message("<span class = 'danger'><big>The rear hull gets damaged!</big></span>")
			if ("frontleft")
				if (F.w_left[5] > 0 && F.w_front[5] > 0)
					if (F.w_left[4] > F.w_front[4] && F.w_left[5]>0)
						F.w_left[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The left hull gets damaged!</big></span>")
					else
						F.w_front[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The front hull gets damaged!</big></span>")
			if ("frontright")
				if (F.w_right[5] > 0 && F.w_front[5] > 0)
					if (F.w_right[4] > F.w_front[4] && F.w_right[5]>0)
						F.w_right[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The right hull gets damaged!</big></span>")
					else
						F.w_front[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The front hull gets damaged!</big></span>")
			if ("backleft")
				if (F.w_left[5] > 0 && F.w_back[5] > 0)
					if (F.w_left[4] > F.w_back[4] && F.w_left[5]>0)
						F.w_left[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The left hull gets damaged!</big></span>")
					else
						F.w_back[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The rear hull gets damaged!</big></span>")
			if ("backright")
				if (F.w_right[5] > 0 && F.w_back[5] > 0)
					if (F.w_right[4] > F.w_back[4] && F.w_right[5]>0)
						F.w_right[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The right hull gets damaged!</big></span>")
					else
						F.w_back[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The rear hull gets damaged!</big></span>")

// grenades set off other grenades, but only ones on the same turf
/obj/item/weapon/grenade/ex_act(severity)
	switch (severity)
		if (8.0)
			fast_activate()
		if (10.0, 13.0)
			return // infinite recursive grenades are gone

/obj/item/weapon/grenade/bullet_act(var/obj/item/projectile/proj)
	if (proj && !proj.nodamage)
		return ex_act(3.0)
	return FALSE

/obj/item/weapon/grenade/old_grenade
	name = "ручная бомба"
	desc = "Маленькая ручная бомба с 5-секундным запалом."
	heavy_armor_penetration = 5
	var/explosion_size = 2

/obj/item/weapon/grenade/old_grenade/prime()
	set waitfor = 0
	..()

	var/turf/T = get_turf(src)
	if(!T) return

	if(explosion_size)
		explosion(T,1,1,3,1,sound=explosion_sound)
		damage_hull(T)
		qdel(src)

/obj/item/weapon/grenade/bomb
	name = "пороховая бочкобомба"
	desc = "Плотно закрытая пороховая бочка. У неё виднеется фитиль на 10 секунд, возможно."
	icon_state = "bomb"
	var/explosion_size = 3
	nothrow = TRUE
	throw_speed = 1
	throw_range = 2
	flags = CONDUCT
	slot_flags = SLOT_BELT
	explosion_sound = 'sound/weapons/Explosives/Dynamite.ogg'
/obj/item/weapon/grenade/bomb/New()
	..()
	det_time = rand(80,120)
/obj/item/weapon/grenade/bomb/prime()
	set waitfor = 0
	..()

	var/turf/O = get_turf(src)
	if(!O) return

	if(explosion_size)
		explosion(O,1,2,3,1,sound=explosion_sound)
		qdel(src)


/obj/item/weapon/grenade/dynamite
	name = "пустая динамитная шашка"
	desc = "В ней ничего нет."
	icon_state = "dynamite0"
	det_time = 40
	explosion_sound = 'sound/weapons/Explosives/Dynamite.ogg'
	var/explosion_size = 2
	var/state = 0

/obj/item/weapon/grenade/dynamite/prime()
	set waitfor = 0
	..()

	var/turf/O = get_turf(src)
	if(!O) return

	if(explosion_size)
		explosion(O,0,2,4,2,sound=explosion_sound)
		for (var/turf/floor/dirt/underground/U in range(2,src))
			U.mining_proc()
		qdel(src)

/obj/item/weapon/grenade/dynamite/attack_self(mob/user as mob)
	if (state == 2)
		activate()
		firer = user
	return

/obj/item/weapon/grenade/dynamite/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (state == 2 && istype(W, /obj/item/flashlight))
		var/obj/item/flashlight/F = W
		if (F.on)
			firer = user
			activate(user)
			add_fingerprint(user)
			name = "зажжённая динамитная шашка"
			desc = "НАХУЙ ТЫ ЭТО ОСМАТРИВАЕШЬ? БРОСАЙ БЛЯДЬ!"
			state = 3
			icon_state = "dynamite3"

			// clicking a grenade a second time turned throw mode off, this fixes that
			if (ishuman(user))
				var/mob/living/human/H = user
				if(istype(H) && !H.in_throw_mode)
					H.throw_mode_on()
			return
	else if (state == 1 && istype(W, /obj/item/stack/material/rope))
		var/obj/item/stack/material/rope/R = W
		if (R.amount == 1)
			qdel(R)
		else
			R.amount -= 1
		state = 2
		user << "Приделал верёвку как фитиль к [src]."
		name = "динамитная шашка"
		desc = "Шашка которая взрывается если дёрнуть фитиль."
		icon_state = "dynamite2"
		return
	else if (state == 0 && istype(W, /obj/item/weapon/reagent_containers))
		var/obj/item/weapon/reagent_containers/RG = W
		if (RG.reagents.has_reagent("nitroglycerin",2))
			RG.reagents.remove_reagent("nitroglycerin",2)
			user << "Заполняю [src] взрывной смесью."
			state = 1
			name = "заполненая динамитная шашка"
			desc = "Шашка которая не взорвётся без фитиля."
			icon_state = "dynamite1"
			return
	else
		return

/obj/item/weapon/grenade/dynamite/dropped(mob/user)
	. = ..()
	if(ishuman(user) && active)
		var/mob/living/human/H = user
		H.throw_mode_off()

/obj/item/weapon/grenade/dynamite/ready
	state = 2
	name = "динамитная шашка"
	desc = "Шашка которая взрывается если дёрнуть фитиль."
	icon_state = "dynamite2"
	update_icon()

/obj/item/weapon/grenade/dynamite/activate(mob/user as mob)
	if (active)
		return

	if (user)
		msg_admin_attack("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)", user.ckey)
		message_admins("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)", user.ckey)
		log_game("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")


	icon_state = "dynamite3"
	active = TRUE
	playsound(loc, armsound, 75, TRUE, -3)
	update_icon()
	spawn(det_time)
		visible_message("<span class = 'warning'>Фитиль [src] сгорает!</span>")
		prime()
		return

/obj/item/weapon/grenade/modern
	name = "граната"
	desc = "Ручная граната с 5-секундным запалом."
	var/explosion_size = 2
	var/fragment_type = /obj/item/projectile/bullet/pellet/fragment
	var/num_fragments = 30  //total number of fragments produced by the grenade
	var/fragment_damage = 15
	var/damage_step = 2	  //projectiles lose a fragment each time they travel this distance. Can be a non-integer.
	var/big_bomb = FALSE
	var/spread_range = 7
	heavy_armor_penetration = 3
	explosion_sound = 'sound/weapons/Explosives/FragGrenade.ogg'
/obj/item/weapon/grenade/modern/prime()
	set waitfor = 0
	..()

	var/turf/T = get_turf(src)
	if(!T) return

	if(explosion_size)
		explosion(T,1,1,3,1,sound=explosion_sound)
		damage_hull(T)
	if (!ismob(loc))

		var/list/target_turfs = getcircle(T, spread_range)
		var/fragments_per_projectile = round(num_fragments/target_turfs.len)

		for (var/turf/TT in target_turfs)
			var/obj/item/projectile/bullet/pellet/fragment/P = new fragment_type(T)
			P.damage = fragment_damage
			P.pellets = fragments_per_projectile
			P.range_step = damage_step
			P.shot_from = name
			P.launch_fragment(TT)
			P.firer_loc = get_turf(src)

			// any mob on the source turf, lying or not, absorbs 100% of shrapnel now
			for (var/mob/living/L in T)
				P.attack_mob(L, 0, 0)

	spawn (5)
		qdel(src)

/obj/item/weapon/grenade/modern/fart
	name = "говнограната"
	desc = "Эти гранаты были изобретены в альтернативной вселенной где Советский Союз захватил весь мир."
	icon_state = "mills"
	explosion_size = 0
	fragment_type = /obj/item/projectile/bullet/pellet/poo
	num_fragments = 30  //total number of fragments produced by the grenade
	det_time = 70
	throw_range = 7
	explosion_sound = 'sound/weapons/Explosives/FTGrenade.ogg'

/obj/item/weapon/grenade/coldwar/a50cal
	name = "антиматериальная граната"
	desc = "Граната изобретённая на сверхсекретной базе Соединёных Штат Америки и начинена патронами .50 калибра."
	icon_state = "m26"
	fragment_type = /obj/item/projectile/bullet/pellet/a50cal
	det_time = 50
	throw_range = 9
	num_fragments = 30
	explosion_sound = 'sound/weapons/Explosives/FragGrenade.ogg'

/obj/item/weapon/grenade/coldwar/a50cal/ap
	name = "антиматериальная \"проникающая\" граната"
	desc = "Граната изобретённая на сверхсекретной базе Соединёных Штат Америки и начинена патронами .50 калибра пробивающая любую броню кроме танков."
	icon_state = "mk2"
	num_fragments = 30
	fragment_type = /obj/item/projectile/bullet/pellet/a50cal_ap

/obj/item/weapon/grenade/coldwar/a50cal/he
	name = "антиматериальная \"взрывная\" граната"
	desc = "Граната изобретённая на сверхсекретной базе Соединёных Штат Америки и начинена патронами .50 калибра разрывающая человека на части."
	icon_state = "m67"
	num_fragments = 30
	fragment_type = /obj/item/projectile/bullet/pellet/a50cal_he

/obj/item/weapon/grenade/coldwar/a50cal/he/OHSHIT
	name = "антиматериальная \"взрывная\" усиленая граната"
	desc = "Граната изобретённая на сверхсекретной базе Соединёных Штат Америки и начинена патронами .50 калибра разрывающая всё на части. <b>Виднеется этикетка: НЕ ИСПОЛЬЗОВАТЬ - НЕСТАБИЛЬНЫЙ ОБРАЗЕЦ!</b>"
	icon_state = "m67"
	num_fragments = 120
	fragment_type = /obj/item/projectile/bullet/pellet/a50cal_he

/obj/item/weapon/grenade/modern/mills
	name = "граната No.5"
	desc = "Граната Миллса изобретённая в Британии в 20 веке."
	icon_state = "mills"
	det_time = 70
	throw_range = 7
	explosion_sound = 'sound/weapons/Explosives/FragGrenade.ogg'

/obj/item/weapon/grenade/ww2/mills2
	name = "граната No.36M"
	desc = "Граната Миллса изобретённая в Британии в 20 веке с 4-секундным запалом."
	icon_state = "mills"
	det_time = 40
	throw_range = 7

/obj/item/weapon/grenade/modern/f1
	name = "граната F1"
	desc = "Французская граната начала 20 века, также использовавшаяся в России."
	icon_state = "f1"
	det_time = 40
	throw_range = 8

/obj/item/weapon/grenade/modern/stg1915
	name = "ручная граната M1915"
	desc = "Немецкая граната начала 20 века."
	icon_state = "stgnade"
	det_time = 45
	throw_range = 10

/obj/item/weapon/grenade/ww2/stg1924 //offensive grenade with minimal fragmentation
	name = "ручная граната M1924"
	desc = "Немецкая граната, замена ручной гранате M1915."
	icon_state = "stgnade"
	det_time = 45
	throw_range = 11
	explosion_size = 2
	num_fragments = 6
	fragment_damage = 20
	damage_step = 1
	spread_range = 7

/obj/item/weapon/grenade/modern/thermaldetonator
	name = "термограната"
	desc = "Созданый по заказу БласТех Индастриз, данная термальная граната может уничтожить всё вокруг себя в довольно большом радиусе."
	icon_state = "detonator"
	det_time = 35
	throw_range = 12

/obj/item/weapon/grenade/modern/t68
	name = "граната Type68"
	desc = "Усовершенствованная модель гранаты Type67 используемая Китайской армией."
	icon_state = "t68"
	det_time = 35
	throw_range = 12

/obj/item/weapon/grenade/ww2/rgd33
	name = "граната РГД-33"
	desc = "Граната созданая на основе гранаты Рдултовского образца 1914/30 года используемая Советской армией."
	icon_state = "rgd33"
	det_time = 50
	throw_range = 9

/obj/item/weapon/grenade/ww2/rg42
	name = "RG-42 grenade"
	desc = "A Soviet fragmentation grenade."
	icon_state = "rg42"
	det_time = 50
	throw_range = 10

/obj/item/weapon/grenade/ww2/mk2
	name = "граната марк 2"
	desc = "Американская оборонительная ручная граната 1918 года."
	icon_state = "mk2"
	det_time = 50
	throw_range = 8

/obj/item/weapon/grenade/ww2/type97
	name = "граната Type97"
	desc = "Японская граната, появившаяся во время второй китайско-японской войны. Взрывается через 5 секунд."
	icon_state = "type97"
	det_time = 50
	throw_range = 10

/obj/item/weapon/grenade/ww2/type91
	name = "граната Type91"
	desc = "Японская граната, появившаяся во время второй китайско-японской войны. Взрывается на 8 секунде."
	icon_state = "type91"
	det_time = 80
	throw_range = 10
	explosion_sound = 'sound/weapons/Explosives/FragGrenade.ogg'

/obj/item/weapon/grenade/coldwar/m26
	name = "граната M26"
	desc = "Американская граната, созданая в 1950-х годах."
	icon_state = "m26"
	det_time = 50
	throw_range = 9
	explosion_sound = 'sound/weapons/Explosives/FragGrenade.ogg'

/obj/item/weapon/grenade/coldwar/stinger
	name = "травматическая граната"
	desc = "Менее смертоносная граната, которая взрывается взрывом резиновых шариков."
	icon_state = "sting"
	det_time = 50
	throw_range = 10
	explosion_sound = 'sound/weapons/Explosives/FragGrenade.ogg'
	fragment_type = /obj/item/projectile/bullet/pellet/rubberball
	explosion_size = 0

/obj/item/weapon/grenade/coldwar/m67
	name = "граната M67"
	desc = "Американская граната, созданая для замены M26."
	icon_state = "m67"
	det_time = 50
	throw_range = 10

/obj/item/weapon/grenade/coldwar/hg85
	name = "HG 85 grenade"
	desc = "The HG 85 is a round fragmentation hand grenade designed for the Swiss Armed Forces."
	icon_state = "hg85"
	det_time = 50
	throw_range = 10

/obj/item/weapon/grenade/coldwar/hg85/l109
	name = "L109 grenade"
	desc = "The L109 is the British designation for the HG 85. It differs from the HG 85 in that it has a special safety clip, which is similar to the safety clip on the American M67 grenade."
	icon_state = "l109"
	det_time = 50
	throw_range = 10

/obj/item/weapon/grenade/coldwar/rgd5
	name = "RGD-5 grenade"
	desc = "Советская наступательная ручная граната изобретённая в 1950-х годах."
	icon_state = "rgd5"
	det_time = 50
	throw_range = 11

/obj/item/weapon/grenade/ww2/prime()
	set waitfor = 0
	..()

	var/turf/T = get_turf(src)
	if(!T) return

	if(explosion_size)
		explosion(T,1,1,3,1,sound=explosion_sound)
		damage_hull(T)
	if (!ismob(loc))

		var/list/target_turfs = getcircle(T, spread_range)
		var/fragments_per_projectile = round(num_fragments/target_turfs.len)

		for (var/turf/TT in target_turfs)
			var/obj/item/projectile/bullet/pellet/fragment/P = new fragment_type(T)
			P.damage = fragment_damage
			P.pellets = fragments_per_projectile
			P.range_step = damage_step
			P.shot_from = name
			P.launch_fragment(TT)

			// any mob on the source turf, lying or not, absorbs 100% of shrapnel now
			for (var/mob/living/L in T)
				P.attack_mob(L, 0, 0)

	spawn (5)
		qdel(src)

/obj/item/weapon/grenade/coldwar/prime()
	set waitfor = 0
	..()

	var/turf/T = get_turf(src)
	if(!T) return

	if(explosion_size)
		explosion(T,1,1,4,1,sound=explosion_sound)
		damage_hull(T)
	if (!ismob(loc))

		var/list/target_turfs = getcircle(T, spread_range)
		var/fragments_per_projectile = round(num_fragments/target_turfs.len)

		for (var/turf/TT in target_turfs)
			var/obj/item/projectile/bullet/pellet/fragment/P = new fragment_type(T)
			P.damage = fragment_damage
			P.pellets = fragments_per_projectile
			P.range_step = damage_step
			P.shot_from = name
			P.launch_fragment(TT)

			// any mob on the source turf, lying or not, absorbs 100% of shrapnel now
			for (var/mob/living/L in T)
				P.attack_mob(L, 0, 0)

	spawn (5)
		qdel(src)

/obj/item/weapon/grenade/coldwar/nonfrag/m26
	name = "взрывная граната M26"
	desc = "Американская граната, созданая в 1950-х годах без шрапнели."
	icon_state = "m26_explosive"
	det_time = 50
	throw_range = 10

/obj/item/weapon/grenade/coldwar/nonfrag/prime()
	set waitfor = 0
	..()

	var/turf/T = get_turf(src)
	if(!T) return

	if(explosion_size)
		explosion(T,1,3,3,1,sound=explosion_sound)
		qdel(src)

/obj/item/weapon/grenade/ww2
	heavy_armor_penetration = 5
	var/fragment_type = /obj/item/projectile/bullet/pellet/fragment
	var/num_fragments = 37  //total number of fragments produced by the grenade
	var/fragment_damage = 15
	var/damage_step = 2	  //projectiles lose a fragment each time they travel this distance. Can be a non-integer.
	var/big_bomb = FALSE
	secondary_action = TRUE
	var/explosion_size = 2
	var/spread_range = 7

/obj/item/weapon/grenade/modern
	secondary_action = TRUE

/obj/item/weapon/grenade/coldwar
	heavy_armor_penetration = 6
	var/fragment_type = /obj/item/projectile/bullet/pellet/fragment
	var/num_fragments = 37  //total number of fragments produced by the grenade
	var/fragment_damage = 15
	var/damage_step = 2	  //projectiles lose a fragment each time they travel this distance. Can be a non-integer.
	var/big_bomb = FALSE

	//The radius of the circle used to launch projectiles. Lower values mean less projectiles are used but if set too low gaps may appear in the spread pattern
	var/spread_range = 7
	secondary_action = TRUE
	var/explosion_size = 2

/obj/item/weapon/grenade/secondary_attack_self(mob/living/human/user)
	if (secondary_action)
		var/inp = WWinput(user, "Создать импровизированную растяжку?", "Минируем?", "No", list("Yes","No"))
		if (inp == "Yes")
			message_admins("<span class = 'warning'>!!!</span> [user.name] ([user.ckey]) минирует тайл под собой \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>) <span class = 'warning'>!!!</span>")
			log_game("<span class = 'warning'>!!!</span> [user.name] ([user.ckey]) минирует тайл под собой \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>) <span class = 'warning'>!!!</span>")
			user << "Ставлю растяжку..."
			if (do_after(user, 100, src))
				if (src)
					message_admins("<span class = 'warning'>!!!</span> [user.name] ([user.ckey]) заминировал тайл под собой с помощью \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>) <span class = 'warning'>!!!</span>")
					log_game("<span class = 'warning'>!!!</span> [user.name] ([user.ckey]) заминировал тайл под собой с помощью \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>) <span class = 'warning'>!!!</span>")
					user << "Успешно сделал растяжку использовав [src]."
					var/obj/item/mine/boobytrap/BT = new /obj/item/mine/boobytrap(get_turf(user))
					BT.origin = src.type
					firer = user
					message_admins("[user.name] ([user.ckey]) placed a boobytrap from \a [src] at ([user.x],[user.y],[user.z])(<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)", user.ckey)
					log_game("[user.name] ([user.ckey]) placed a boobytrap from \a [src] at ([user.x],[user.y],[user.z])(<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")
					qdel(src)
		else
			return

/obj/item/weapon/grenade/suicide_vest
	name = "пояс смертника"
	desc = "Самодельный пояс смертинка. الله أكبر!"
	icon_state = "suicide_vest"
	nothrow = TRUE
	throw_speed = 1
	throw_range = 2
	flags = CONDUCT
	slot_flags = SLOT_BELT
	det_time = 10
	var/armed = "disarmed"

/obj/item/weapon/grenade/suicide_vest/prime()
	if (active)
		var/turf/T = get_turf(src)
		if(!T) return
		var/original_mobs = list()
		var/original_objs = list()

		explosion(T,2,3,3,3)
		for (var/mob/living/L in T.contents)
			original_mobs += L
			if (L.client)
				L.canmove = FALSE
				L.gib()
		for (var/obj/O in T.contents)
			original_objs += O
		playsound(T, "explosion", 100, TRUE)
		spawn (1)
			for (var/mob/living/L in range(1,T))
				if (L)
					L.maim()
					if (L)
						L.canmove = TRUE
			for (var/obj/O in original_objs)
				if (O)
					O.ex_act(1.0)
			T.ex_act(1.0)
		qdel(src)


/obj/item/weapon/grenade/suicide_vest/examine(mob/user)
	..()
	user << "\The [src] is <b>[armed]</b>."
	return

/obj/item/weapon/grenade/suicide_vest/attack_self(mob/user as mob)
	if (!active && armed == "armed")
		user << "<span class='warning'>Активирую [name]!</span>"
		activate(user)
		add_fingerprint(user)

/obj/item/weapon/grenade/suicide_vest/attack_hand(mob/user as mob)
	if (!active && armed == "armed" && loc == user)
		user << "<span class='warning'>Активирую [name]!</span>"
		activate(user)
		add_fingerprint(user)
	else
		..()

/obj/item/weapon/grenade/suicide_vest/verb/arm()
	set category = "Умения"
	set name = "Переключить пояс"
	set src in range(1, usr)

	if (armed == "armed")
		usr << "Переключаю [src]. Теперь он не взорвётся."
		armed = "disarmed"
		return
	else
		usr << "<span class='warning'>Переключаю [src]! Теперь он готов взорваться!</span>"
		armed = "armed"
		return

/obj/item/weapon/grenade/suicide_vest/activate(mob/living/human/user as mob)
	if (active)
		return

	if (user)
		msg_admin_attack("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)", user.ckey)
		message_admins("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)", user.ckey)
		log_game("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")

	if (user && user.faction_text == ARAB)
		user.emote("charge")
	active = TRUE
	playsound(loc, armsound, 75, TRUE, -3)

	spawn(det_time)
		visible_message("<span class = 'warning'>[src] сейчас взорвётся!</span>")
		prime()
		return

/obj/item/weapon/grenade/suicide_vest/kamikaze
	name = "пояс камикадзе"
	desc = "Противотанковый пояс камикадзе. バンザイ！"
	icon_state = "kamikaze_vest"
	nothrow = TRUE
	throw_speed = 1
	throw_range = 2
	flags = CONDUCT
	slot_flags = SLOT_BELT
	det_time = 1
	heavy_armor_penetration = 22
	var/armed1 = "disarmed"

/obj/item/weapon/grenade/suicide_vest/kamikaze/examine(mob/user)
	..()
	user << "\The [src] is <b>[armed]</b>."
	return

/obj/item/weapon/grenade/suicide_vest/kamikaze/attack_self(mob/user as mob)
	if (!active && armed1 == "armed")
		user << "<span class='warning'>Активирую [name]!</span>"
		firer = user
		activate(user)
		add_fingerprint(user)

/obj/item/weapon/grenade/suicide_vest/kamikaze/attack_hand(mob/user as mob)
	if (!active && armed1 == "armed" && loc == user)
		user << "<span class='warning'>Активирую [name]!</span>"
		firer = user
		activate(user)
		add_fingerprint(user)
	else
		..()

/obj/item/weapon/grenade/suicide_vest/kamikaze/verb/arm1()
	set category = "Умения"
	set name = "Переключить пояс"
	set src in range(1, usr)

	if (armed1 == "armed")
		usr << "Переключаю [src]. Теперь он не взорвётся!"
		armed1 = "disarmed"
		firer = null
		return
	else
		usr << "<span class='warning'>Переключаю [src]! Теперь он готов взорваться!</span>"
		armed1 = "armed"
		return

/obj/item/weapon/grenade/suicide_vest/kamikaze/activate(mob/living/human/user as mob)
	if (active)
		return

	if (user)
		msg_admin_attack("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)", user.ckey)
		message_admins("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)", user.ckey)
		log_game("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")

	if (user && user.faction_text == JAPANESE)
		user.emote("charge")
	active = TRUE
	playsound(loc, armsound, 75, TRUE, -3)

	spawn(det_time)
		visible_message("<span class = 'warning'>[src] сейчас взорвётся!</span>")
		prime()
		return

/obj/item/weapon/grenade/suicide_vest/kamikaze/prime()
	set waitfor = 0

	var/turf/T = get_turf(src.loc)
	if(!T) return

	if (active)
		explosion(T,3,3,3,3)
		for(var/obj/structure/vehicleparts/frame/F in range(1,T))
			for (var/mob/M in F.axis.transporting)
				shake_camera(M, 3, 3)
			var/penloc = F.CheckPenLoc(src)
			switch(penloc)
				if ("left")
					if (F.w_left[5] > 0)
						F.w_left[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The left hull gets damaged!</big></span>")
				if ("right")
					if (F.w_right[5] > 0)
						F.w_right[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The right hull gets damaged!</big></span>")
				if ("front")
					if (F.w_front[5] > 0)
						F.w_front[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The front hull gets damaged!</big></span>")
				if ("back")
					if (F.w_back[5] > 0)
						F.w_back[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The rear hull gets damaged!</big></span>")
				if ("frontleft")
					if (F.w_left[5] > 0 && F.w_front[5] > 0)
						if (F.w_left[4] > F.w_front[4] && F.w_left[5]>0)
							F.w_left[5] -= heavy_armor_penetration
							visible_message("<span class = 'danger'><big>The left hull gets damaged!</big></span>")
						else
							F.w_front[5] -= heavy_armor_penetration
							visible_message("<span class = 'danger'><big>The front hull gets damaged!</big></span>")
				if ("frontright")
					if (F.w_right[5] > 0 && F.w_front[5] > 0)
						if (F.w_right[4] > F.w_front[4] && F.w_right[5]>0)
							F.w_right[5] -= heavy_armor_penetration
							visible_message("<span class = 'danger'><big>The right hull gets damaged!</big></span>")
						else
							F.w_front[5] -= heavy_armor_penetration
							visible_message("<span class = 'danger'><big>The front hull gets damaged!</big></span>")
				if ("backleft")
					if (F.w_left[5] > 0 && F.w_back[5] > 0)
						if (F.w_left[4] > F.w_back[4] && F.w_left[5]>0)
							F.w_left[5] -= heavy_armor_penetration
							visible_message("<span class = 'danger'><big>The left hull gets damaged!</big></span>")
						else
							F.w_back[5] -= heavy_armor_penetration
							visible_message("<span class = 'danger'><big>The rear hull gets damaged!</big></span>")
				if ("backright")
					if (F.w_right[5] > 0 && F.w_back[5] > 0)
						if (F.w_right[4] > F.w_back[4] && F.w_right[5]>0)
							F.w_right[5] -= heavy_armor_penetration
							visible_message("<span class = 'danger'><big>The right hull gets damaged!</big></span>")
						else
							F.w_back[5] -= heavy_armor_penetration
							visible_message("<span class = 'danger'><big>The rear hull gets damaged!</big></span>")
			F.try_destroy()
			for(var/obj/structure/vehicleparts/movement/MV in F)
				MV.broken = TRUE
				MV.update_icon()
			F.update_icon()
		qdel(src)

/obj/item/weapon/grenade/coldwar/nonfrag/custom
	name = "взрывная граната"
	desc = "Взрывная граната без шрапнели."	//This is a plain lie
	icon_state = "m26"
	det_time = 50
	throw_range = 9

/obj/item/weapon/grenade/antitank/custom
	name = "противотанковая граната"
	desc = "Противотанковая граната без шрапнели."
	icon_state = "rpg40"
	det_time = 50
	throw_range = 3
	heavy_armor_penetration = 18

/obj/item/weapon/grenade/modern/custom
	name = "осколочная граната"
	desc = "Граната начинёная осколками."
	icon_state = "mk2"
	det_time = 50
	throw_range = 10

/obj/item/weapon/grenade/antitank
	name = "противотанковая граната"
	desc = "Мощная граната, разрывающая обшивки танков."
	icon_state = "rpg40"
	det_time = 50
	throw_range = 5
	heavy_armor_penetration = 22

/obj/item/weapon/grenade/antitank/rpg40
	name = "РПГ-40"
	icon_state = "rpg40"
	det_time = 50
	throw_range = 5
	heavy_armor_penetration = 23 //about 20–25 millimetres (0.79–0.98 in) of armour can be penetrated

/obj/item/weapon/grenade/antitank/rpg43
	name = "RPG-43"
	desc = "A powerful Soviet AT grenade, useful against armored vehicles."
	icon_state = "rpg43"
	det_time = 50
	throw_range = 6
	heavy_armor_penetration = 30 //The RPG-43 had a penetration of around 75 millimetres, to not make it too op im giving it only 30


/obj/item/weapon/grenade/antitank/stg24_bundle
	name = "M1924 Stielhandgranate bundle"
	desc = "A bundle of M1924 grenades tied together, useful against armored vehicles."
	icon_state = "stgbundle"
	det_time = 50
	throw_range = 6
	heavy_armor_penetration = 18

/obj/item/weapon/grenade/antitank/n73
	name = "N73 AT grenade"
	desc = "A British anti-tank hand percussion grenade used during WW2. Also known as \"Thermos\". "
	icon_state = "n73"
	heavy_armor_penetration = 27 //it was able to penetrate 2 inches (51 mm) for balance im making it 27
	throw_range = 5

/obj/item/weapon/grenade/antitank/n74
	name = "N74 AT grenade"
	desc = "A British anti-tank hand grenade used during WW2. Also known as the \"Sticky Bomb\"."
	icon_state = "n74"
	heavy_armor_penetration = 18

/obj/item/weapon/grenade/antitank/n75
	name = "n75 AT grenade"
	desc = "A British anti-tank hand grenade used during WW2. Also known as the \"Hawkins grenade\". Can also be used as an AT-mine."
	icon_state = "n75"
	heavy_armor_penetration = 22
	throw_range = 7
	secondary_action = TRUE

/obj/item/weapon/grenade/antitank/n75/secondary_attack_self(mob/living/human/user)
	if (secondary_action)
		var/inp = WWinput(user, "Are you sure you want to place an anti-tank mine here?", "Mining", "No", list("Yes","No"))
		if (inp == "Yes")
			user << "Placing the mine..."
			if (do_after(user, 60, src))
				if (src)
					user << "You successfully place the mine here using \the [src]."
					var/obj/item/mine/at/armed/BT = new /obj/item/mine/at/armed(get_turf(user))
					BT.origin = src.type
					firer = user
					qdel(src)
		else
			return

/obj/item/weapon/grenade/antitank/type99
	name = "противотанковая мина Type99"
	icon_state = "type99"
	desc = "Японская противотанковая мина которую можно использовать как гранату."
	det_time = 50
	throw_range = 8
	secondary_action = TRUE

/obj/item/weapon/grenade/antitank/type99/secondary_attack_self(mob/living/human/user)
	if (secondary_action)
		var/inp = WWinput(user, "Заложить мину?", "Минирование", "No", list("Yes","No"))
		if (inp == "Yes")
			user << "Ставлю мину..."
			if (do_after(user, 60, src))
				if (src)
					user << "Успешно поставил [src]."
					var/obj/item/mine/at/armed/BT = new /obj/item/mine/at/armed(get_turf(user))
					BT.origin = src.type
					firer = user
					qdel(src)
		else
			return

/obj/item/weapon/grenade/antitank/prime()
	set waitfor = 0
	..()

	var/turf/T = get_turf(src)
	if(!T) return

	explosion(T,2,2,2,2,sound=explosion_sound)
	for(var/obj/structure/vehicleparts/frame/F in range(1,T))
		for (var/mob/M in F.axis.transporting)
			shake_camera(M, 3, 3)
		var/penloc = F.CheckPenLoc(src)
		switch(penloc)
			if ("left")
				if (F.w_left[5] > 0)
					F.w_left[5] -= heavy_armor_penetration
					visible_message("<span class = 'danger'><big>The left hull gets damaged!</big></span>")
			if ("right")
				if (F.w_right[5] > 0)
					F.w_right[5] -= heavy_armor_penetration
					visible_message("<span class = 'danger'><big>The right hull gets damaged!</big></span>")
			if ("front")
				if (F.w_front[5] > 0)
					F.w_front[5] -= heavy_armor_penetration
					visible_message("<span class = 'danger'><big>The front hull gets damaged!</big></span>")
			if ("back")
				if (F.w_back[5] > 0)
					F.w_back[5] -= heavy_armor_penetration
					visible_message("<span class = 'danger'><big>The rear hull gets damaged!</big></span>")
			if ("frontleft")
				if (F.w_left[5] > 0 && F.w_front[5] > 0)
					if (F.w_left[4] > F.w_front[4] && F.w_left[5]>0)
						F.w_left[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The left hull gets damaged!</big></span>")
					else
						F.w_front[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The front hull gets damaged!</big></span>")
			if ("frontright")
				if (F.w_right[5] > 0 && F.w_front[5] > 0)
					if (F.w_right[4] > F.w_front[4] && F.w_right[5]>0)
						F.w_right[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The right hull gets damaged!</big></span>")
					else
						F.w_front[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The front hull gets damaged!</big></span>")
			if ("backleft")
				if (F.w_left[5] > 0 && F.w_back[5] > 0)
					if (F.w_left[4] > F.w_back[4] && F.w_left[5]>0)
						F.w_left[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The left hull gets damaged!</big></span>")
					else
						F.w_back[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The rear hull gets damaged!</big></span>")
			if ("backright")
				if (F.w_right[5] > 0 && F.w_back[5] > 0)
					if (F.w_right[4] > F.w_back[4] && F.w_right[5]>0)
						F.w_right[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The right hull gets damaged!</big></span>")
					else
						F.w_back[5] -= heavy_armor_penetration
						visible_message("<span class = 'danger'><big>The rear hull gets damaged!</big></span>")
		F.try_destroy()
		for(var/obj/structure/vehicleparts/movement/MV in F)
			MV.broken = TRUE
			MV.update_icon()
		F.update_icon()
		if (firer)
			firer.awards["tank"]+=(heavy_armor_penetration/200)
	qdel(src)
