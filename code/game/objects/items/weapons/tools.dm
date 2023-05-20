//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/* Tools!
 * Note: Multitools are /obj/item
 *
 * Contains:
 * 		Wrench
 * 		Screwdriver
 * 		Wirecutters
 * 		Welding Tool
 * 		Crowbar
 */

/*
 * Wrench
 */
/obj/item/weapon/wrench
	name = "гаечный ключ"
	desc = "Необходим если надо открутить или прикрутить (не)нужный предмет к полу."
	icon = 'icons/obj/items.dmi'
	icon_state = "wrench"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = WEAPON_FORCE_NORMAL
	throwforce = WEAPON_FORCE_NORMAL
	w_class = ITEM_SIZE_SMALL

	attack_verb = list("прикручивает", "забивает", "избивает", "ударил")

/obj/item/weapon/metalfile
	name = "metalfile"
	desc = "A metal file, maybe you could file through metal with this."
	icon = 'icons/obj/items.dmi'
	icon_state = "metalfile"
	flags = CONDUCT
	slot_flags = SLOT_POCKET
	force = WEAPON_FORCE_WEAK
	throwforce = WEAPON_FORCE_WEAK
	w_class = ITEM_SIZE_SMALL

	attack_verb = list("bapped", "bonked", "slapped", "whacked")

/*
 * Fire Extinguisher
 */
/obj/item/weapon/fire_extinguisher
	name = "огнетушитель"
	desc = "Тушит огонь."
	icon = 'icons/obj/items.dmi'
	icon_state = "fire_extinguisher"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = WEAPON_FORCE_NORMAL+5
	throwforce = WEAPON_FORCE_NORMAL+5
	w_class = ITEM_SIZE_NORMAL

	attack_verb = list("бахает", "бухает", "долбит", "ударил")
	var/uses = 25
	var/lastfire = 0
	var/max_range = 1
	New()
		..()
		desc = "Похоже в нём осталось [uses] единиц пены."

/obj/item/weapon/fire_extinguisher/proc/fire(var/mob/living/human/H,var/cdir=null,atom/target)
	if (!H)
		return
	if (world.time<=lastfire)
		return
	if (!H.has_empty_hand(both = FALSE))
		H << "<span class='warning'>Надо бы освободить другую руку для использования [src]!</span>"
		return
	if (!cdir)
		cdir = H.dir
	else
		process_foam(H,cdir,target)
		return

/obj/item/weapon/fire_extinguisher/proc/process_foam(var/mob/living/human/user, var/cdir = null, atom/target)
	if (!cdir || !(cdir in list(NORTH,SOUTH,EAST,WEST)))
		cdir = user.dir
	if (uses > 0)
		uses--
		desc = "A fire extinguisher filled with foam. Has [uses] uses left."
		lastfire = world.time+15
		var/turf/source_turf = get_turf(user)

		var/list/turfs = getline2(source_turf, target)

		var/distance = 0
		var/stop_at_turf = FALSE

		playsound(source_turf, 'sound/effects/extinguish.ogg', 100, FALSE)

		for(var/turf/T in turfs)
			if(distance > max_range)
				break

			if(T.density)
				if(!istype(T, /obj/structure/barricade) || !istype(T, /obj/structure/window/barrier))
					stop_at_turf = TRUE
			else
				if (distance > 0)
					new/obj/effect/decal/cleanable/foam(T)
					for (var/obj/effect/fire/F in T)
						qdel(F)
					for (var/mob/living/human/H in T)
						if (H.fire_stacks > 0)
							H.fire_stacks = 0

			if(T == target.loc)
				if(stop_at_turf)
					break
				continue

			if(stop_at_turf)
				break

			distance++
	else
		user << "<span class='warning'>\The [src] is empty.</span>"
		return

/obj/item/weapon/fire_extinguisher/ww2
	name = "огнетушитель"
	desc = "Наполнен противопожарной пеной.."
	icon = 'icons/obj/items.dmi'
	icon_state = "german_fire_extinguisher"

/*
 * Screwdriver
 */
/obj/item/weapon/hammer
	name = "молоток"
	desc = "Молоток с маленькой головкой идеален для разборки предметов."
	icon = 'icons/obj/items.dmi'
	icon_state = "hammer"
	item_state = "hammer"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_POCKET
	force = WEAPON_FORCE_NORMAL + 4
	w_class = ITEM_SIZE_SMALL
	throwforce = WEAPON_FORCE_NORMAL
	throw_speed = 5
	throw_range = 5

	attack_verb = list("колотит", "бьёт")
	flammable = TRUE

/obj/item/weapon/hammer/tribalhammer
	name = "простой деревянный молоток"
	desc = "Грубо сделаный молоток с маленькой головкой идеален для разборки предметов."
	icon = 'icons/misc/tribal.dmi'
	icon_state = "tribalhammer"
	item_state = "tribalhammer"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_POCKET
	force = WEAPON_FORCE_NORMAL + 4
	w_class = ITEM_SIZE_SMALL
	throwforce = WEAPON_FORCE_NORMAL
	throw_speed = 5
	throw_range = 5

	attack_verb = list("колотит", "бьёт")
	flammable = TRUE

/obj/item/weapon/hammer/modern
	name = "молоток"
	desc = "Современный молоток идеален для разборки предметов."
	icon = 'icons/obj/items.dmi'
	icon_state = "hammer_modern"
	item_state = "hammer_modern"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_POCKET
	force = WEAPON_FORCE_NORMAL + 6
	w_class = ITEM_SIZE_SMALL
	throwforce = WEAPON_FORCE_NORMAL
	throw_speed = 6
	throw_range = 5

	attack_verb = list("колотит", "бьёт")
	flammable = FALSE

/obj/item/weapon/globe
	name = "глобус"
	desc = "Модель планеты."
	icon = 'icons/obj/items.dmi'
	icon_state = "globe"
	item_state = "globe"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = WEAPON_FORCE_NORMAL + 1
	w_class = ITEM_SIZE_SMALL
	throwforce = WEAPON_FORCE_NORMAL
	throw_speed = 5
	throw_range = 5

	attack_verb = list("забивает", "бьёт")
	flammable = TRUE


/*
 * Wirecutters
 */

/obj/item/weapon/wirecutters
	name = "кусачки"
	desc = "Обкусывают провода."
	icon = 'icons/obj/items.dmi'
	icon_state = "cutters-y"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = WEAPON_FORCE_WEAK
	throw_speed = 2
	throw_range = 9
	w_class = ITEM_SIZE_SMALL
	attack_verb = list("обкусывает", "делает кусь")
	sharp = TRUE
	edge = TRUE

/obj/item/weapon/wirecutters/New()
	if (!istype(src, /obj/item/weapon/wirecutters/boltcutters))
		if (prob(50))
			icon_state = "cutters-y"
			item_state = "cutters_yellow"
	..()

/obj/item/weapon/wirecutters/attack(mob/living/human/C as mob, mob/user as mob)
	..()

/*
 * Crowbar
 */

/obj/item/weapon/crowbar
	name = "лом"
	desc = "Подцепляет плитки пола и вскрывает обесточеные автоматические двери."
	icon = 'icons/obj/items.dmi'
	icon_state = "crowbar"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = WEAPON_FORCE_PAINFUL
	throwforce = WEAPON_FORCE_NORMAL
	item_state = "crowbar"
	w_class = ITEM_SIZE_SMALL

	attack_verb = list("ударил", "ломает", "бацает", "делает бонк", "ударил")

/obj/item/weapon/horn
	name = "горн"
	desc = "Труба для призыва делать что-то."
	icon = 'icons/misc/tribal.dmi'
	icon_state = "tribalhorn"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = WEAPON_FORCE_WEAK
	throwforce = WEAPON_FORCE_WEAK
	item_state = "zippo"
	w_class = ITEM_SIZE_SMALL
	flags = FALSE

	attack_verb = list("бьёт", "призывает", "долбит", "хреначит", "ударил")
	var/cooldown_horn = FALSE

/obj/item/weapon/horn/attack_self(mob/user as mob)
	if (cooldown_horn == FALSE)
		playsound(loc, 'sound/effects/blowing_horn.ogg', 100, FALSE, 25)
		user.visible_message("<span class='warning'>[user] трубит в [name]!</span>")
		cooldown_horn = TRUE
		spawn(100)
			cooldown_horn = FALSE
		return

/obj/item/weapon/whistle
	name = "свисток"
	desc = "Для тех кто не умеет свистеть. Не плохо привлекает внимание."
	icon = 'icons/obj/items.dmi'
	icon_state = "whistle"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = WEAPON_FORCE_HARMLESS
	throwforce = WEAPON_FORCE_HARMLESS
	item_state = "zippo"
	w_class = ITEM_SIZE_SMALL

	attack_verb = list("бьёт")
	var/cooldown = FALSE

/obj/item/weapon/whistle/attack_self(mob/user as mob)
	if (!cooldown)
		playsound(loc, 'sound/effects/whistle.ogg', 100, FALSE, 5)
		user.visible_message("<span class='warning'>[user] свистит в [name]!</span>")
		cooldown = TRUE
		spawn(10 SECONDS)
			cooldown = FALSE
		return

/obj/item/weapon/deathwhistle
	name = "свисток смерти"
	desc = "Подходит для запугивания вражеских солдат."
	icon = 'icons/obj/items.dmi'
	icon_state = "death_whistle"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = WEAPON_FORCE_HARMLESS
	throwforce = WEAPON_FORCE_HARMLESS
	item_state = "zippo"
	w_class = ITEM_SIZE_SMALL

	attack_verb = list("attacked", "whacked")
	var/cooldown = FALSE

/obj/item/weapon/deathwhistle/attack_self(mob/user as mob)
	if (!cooldown)
		playsound(loc, 'sound/effects/death-whistle.ogg', 100, FALSE, 5)
		user.visible_message("<span class='warning'>[user] sounds the [name]!</span>")
		cooldown = TRUE
		spawn(10 SECONDS)
			cooldown = FALSE
		return

/obj/item/weapon/siegeladder
	name = "лестница"
	desc = "Её ставят на стены и по ней взбираются."
	icon = 'icons/obj/stairs.dmi'
	icon_state = "siege_ladder"
	flags = CONDUCT
	force = WEAPON_FORCE_WEAK
	throwforce = WEAPON_FORCE_WEAK
	w_class = ITEM_SIZE_LARGE
	flags = FALSE

	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")
	var/deployed = FALSE
	nothrow = TRUE
	flammable = TRUE
	var/depicon = "siege_ladder_dep"
	var/handicon = "siege_ladder"

/obj/item/weapon/siegeladder/metal
	name = "лестница"
	desc = "Металическая лестница для взбирания."
	icon = 'icons/obj/stairs.dmi'
	icon_state = "metal_ladder"
	flags = CONDUCT
	force = WEAPON_FORCE_WEAK
	throwforce = WEAPON_FORCE_WEAK
	w_class = ITEM_SIZE_LARGE

	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")
	deployed = FALSE
	nothrow = TRUE
	flammable = TRUE
	depicon = "metal_ladder_dep"
	handicon = "metal_ladder"

/obj/item/weapon/siegeladder/attackby(obj/item/weapon/O as obj, mob/user as mob)
	if (deployed)
		user.visible_message(
			"<span class='danger'>[user] убирает [src] от стены!</span>",
			"<span class='danger'>Убираю [src] от стены!</span>")
		if (do_after(user, 80, src))
			user.visible_message(
				"<span class='danger'>[user] убрал [src] от стены!</span>",
				"<span class='danger'>Убрал [src] от стены!</span>")
			anchored = FALSE
			deployed = FALSE
			icon_state = handicon
			for (var/obj/structure/barricade/ST in src.loc)
				ST.climbable = FALSE
	else
		..()

/obj/structure/barricade/attackby(obj/item/weapon/siegeladder/O as obj, mob/living/user as mob)
	if (istype(O, /obj/item/weapon/siegeladder))
		visible_message(
			"<span class='danger'>[user] ставит [O.name] к стене.</span>",
			"<span class='danger'>Ставлю [O.name] к стене.</span>")
		if (do_after(user, 80, src))
			visible_message(
				"<span class='danger'>[user] поставил [O.name] к стене!</span>",
				"<span class='danger'>Ставлю [O.name] к стене!</span><br><b>Что-бы взобраться перетащи себя на лестницу</b>")
			qdel(O)
			var/obj/item/weapon/siegeladder/ANCH = new/obj/item/weapon/siegeladder(src.loc)
			ANCH.anchored = TRUE
			src.climbable = TRUE
			ANCH.deployed = TRUE
			ANCH.icon_state = ANCH.depicon
			ANCH.dir = src.dir
			return
	else
		..()

/obj/item/weapon/fishing
	name = "удочка"
	desc = "Для ловли морских обитателей."
	icon = 'icons/obj/items.dmi'
	icon_state = "fishing"
	slot_flags = SLOT_BACK
	force = WEAPON_FORCE_NORMAL
	throwforce = WEAPON_FORCE_NORMAL
	w_class = ITEM_SIZE_NORMAL
	flags = FALSE

	attack_verb = list("bashed", "whacked")
	flammable = TRUE

/obj/item/weapon/fishing/net
	name = "сеть"
	desc = "Для ловли морсих обитателей если вам лень рыбачить."
	w_class = ITEM_SIZE_SMALL
	icon_state = "fishing_net"
	force = WEAPON_FORCE_WEAK
	throwforce = WEAPON_FORCE_WEAK
	slot_flags = null
	attack_verb = list("slapped")
	flammable = TRUE

/obj/item/weapon/fishing/modern
	name = "сеть"
	desc = "Для ловли морских обитателей если вам лень рыбачить. Выглядит классно."
	icon = 'icons/obj/items.dmi'
	icon_state = "fishing_modern"
	slot_flags = SLOT_BACK
	force = WEAPON_FORCE_NORMAL
	throwforce = WEAPON_FORCE_NORMAL
	w_class = ITEM_SIZE_NORMAL

	attack_verb = list("bashed", "whacked")
	flammable = TRUE

/obj/item/weapon/goldsceptre
	name = "золотой скипетр"
	desc = "Скипетр из золота."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "goldsceptre"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = WEAPON_FORCE_NORMAL+4
	throwforce = WEAPON_FORCE_NORMAL-1
	w_class = ITEM_SIZE_SMALL
	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")

/*
 * Wrench
 */
/obj/item/weapon/shears
	name = "ножницы"
	desc = "Ножницы для состригания с овец шерсти."
	icon = 'icons/obj/items.dmi'
	icon_state = "shears"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	flags = CONDUCT
	force = WEAPON_FORCE_NORMAL
	throwforce = WEAPON_FORCE_NORMAL
	w_class = ITEM_SIZE_SMALL

	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")

//////////////////////////////////////////////////////WELDER///////////////////////////////////////////////////////////
/obj/item/weapon/weldingtool
	name = "сварочный аппарат"
	desc = "Используется для починки предметов."
	icon = 'icons/obj/items.dmi'
	icon_state = "ww2_welder_off"
	var/on_state = "ww2_welder_on"
	var/off_state = "ww2_welder_off"
	flags = CONDUCT
	slot_flags = SLOT_BELT

	//Amount of OUCH when it's thrown
	force = WEAPON_FORCE_WEAK
	throwforce = WEAPON_FORCE_WEAK
	throw_speed = TRUE
	throw_range = 5
	w_class = ITEM_SIZE_NORMAL
	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")
/*	var/welding = FALSE

/obj/item/weapon/weldingtool/process(var/mob/living/human/L, var/obj/item/weapon/reagent_containers/glass/flamethrower/FM = null)
	if (welding)
		if (!L.back || !istype(L.back,/obj/item/weapon/reagent_containers/glass/flamethrower))
			L << "<span class='warning'>You need a fuel tank on your back in order to be able to use a flamethrower!</span>"
			setWelding(0)
			return

		if (istype(L.back,/obj/item/weapon/reagent_containers/glass/flamethrower))
			FM = L.back

		if (!FM)
			L << "<span class='warning'>You need a fuel tank on your back in order to be able to use a flamethrower!</span>"
			setWelding(0)
			return

		if (prob(5))
			remove_fuel(1)

		if (get_fuel(FM) < 1)
			setWelding(0)

/obj/item/weapon/weldingtool/attack_self(mob/user as mob)
	setWelding(!welding, usr)
	return

//Returns the amount of fuel in the welder
/obj/item/weapon/weldingtool/proc/get_fuel(var/obj/item/weapon/reagent_containers/glass/flamethrower/FM)
	return FM.reagents.get_reagent_amount("gasoline")


//Removes fuel from the welding tool. If a mob is passed, it will perform an eyecheck on the mob. This should probably be renamed to use()
/obj/item/weapon/weldingtool/proc/remove_fuel(var/amount = TRUE, var/mob/M = null, var/obj/item/weapon/reagent_containers/glass/flamethrower/FM)
	if (!welding)
		return FALSE
	if (get_fuel() >= amount)
		FM.reagents.remove_reagent("gasoline", amount)
		if (M)
			eyecheck(M)
		return TRUE
	else
		if (M)
			M << "<span class='notice'>You need more welding fuel to complete this task.</span>"
		return FALSE

//Returns whether or not the welding tool is currently on.
/obj/item/weapon/weldingtool/proc/isOn()
	return welding

/obj/item/weapon/weldingtool/update_icon()
	..()
	icon_state = welding ? on_state : off_state
	var/mob/M = loc
	if (istype(M))
		M.update_inv_l_hand()
		M.update_inv_r_hand()

//Sets the welding state of the welding tool. If you see W.welding = TRUE anywhere, please change it to W.setWelding(1)
//so that the welding tool updates accordingly
/obj/item/weapon/weldingtool/proc/setWelding(var/set_welding, var/mob/M, var/obj/item/weapon/reagent_containers/glass/flamethrower/FM)
	var/turf/T = get_turf(src)
	//If we're turning it on
	if (set_welding && !welding)
		if (get_fuel() > 0)
			if (M)
				M << "<span class='notice'>You switch the [src] on.</span>"
			else if (T)
				T.visible_message("<span class='danger'>\The [src] turns on.</span>")
			force = WEAPON_FORCE_PAINFUL
			damtype = "fire"
			w_class = ITEM_SIZE_LARGE
			welding = TRUE
			update_icon()
			set_light(l_range = 1.4, l_power = TRUE, l_color = COLOR_ORANGE)
			processing_objects |= src
		else
			if (M)
				M << "<span class='notice'>You need more welding fuel to complete this task.</span>"
			return
	//Otherwise
	else if (!set_welding && welding)
		processing_objects -= src
		if (M)
			M << "<span class='notice'>You switch \the [src] off.</span>"
		else if (T)
			T.visible_message("<span class='warning'>\The [src] turns off.</span>")
		force = WEAPON_FORCE_WEAK
		damtype = "brute"
		w_class = initial(w_class)
		welding = FALSE
		update_icon()
		set_light(l_range = FALSE, l_power = FALSE, l_color = COLOR_ORANGE)

//Decides whether or not to damage a player's eyes based on what they're wearing as protection
//Note: This should probably be moved to mob
/obj/item/weapon/weldingtool/proc/eyecheck(mob/user as mob)
	if (!ishuman(user))	return TRUE
	if (istype(user, /mob/living/human))
		var/mob/living/human/H = user
		var/obj/item/organ/eyes/E = H.internal_organs_by_name["eyes"]
		if (!E)
			return
		var/safety = H.eyecheck()
		switch(safety)
			if (FLASH_PROTECTION_MODERATE)
				H << "<span class='warning'>Your eyes sting a little.</span>"
				E.damage += rand(1, 2)/2
				if (E.damage > 12)
					H.eye_blurry += rand(3,6)/2
			if (FLASH_PROTECTION_NONE)
				H << "<span class='warning'>Your eyes burn.</span>"
				E.damage += rand(2, 4)/2
				if (E.damage > 10)
					E.damage += rand(4,10)/2
			if (FLASH_PROTECTION_REDUCED)
				H << "<span class='danger'>Your equipment intensify the welder's glow. Your eyes itch and burn severely.</span>"
				H.eye_blurry += rand(12,20)/2
				E.damage += rand(12, 16)/2
		if (safety<FLASH_PROTECTION_MAJOR)
			if (E.damage > 10)
				user << "<span class='warning'>Your eyes are really starting to hurt. This can't be good for you!</span>"

			if (E.damage >= E.min_broken_damage)
				H << "<span class='danger'>You go blind!</span>"
				H.sdisabilities |= BLIND
			else if (E.damage >= E.min_bruised_damage)
				H << "<span class='danger'>You go blind!</span>"
				H.eye_blind = 5
				H.eye_blurry = 5
				H.disabilities |= NEARSIGHTED
				spawn(100)
					H.disabilities &= ~NEARSIGHTED




/obj/item/weapon/reagent_containers/glass/welding_tank
	name = "portable welding tank"
	desc = "A portable welding tank using gasoline as a fuel source."
	icon = 'icons/obj/barrel.dmi'
	icon_state = "welding_tank"
	item_state = "welding_tank"
	flags = CONDUCT
	sharp = FALSE
	edge = FALSE
	flags = CONDUCT
	nothrow = TRUE
	attack_verb = list("bashed", "hit")
	force = WEAPON_FORCE_WEAK
	throwforce = WEAPON_FORCE_WEAK
	flammable = TRUE
	w_class = 10
	slot_flags = SLOT_BACK
	throw_speed = 1
	throw_range = 1
	amount_per_transfer_from_this = 5
	volume = 100
	density = FALSE

/obj/item/weapon/reagent_containers/glass/welding_tank/filled/New()
	..()
	reagents.add_reagent("gasoline",100)
///////////////////////////////////////END OF WELDER/////////////////////////////////////////////////////////////////////////
Shinobi's unfinished welder stuff - siro*/


/obj/item/weapon/gongmallet
	name = "молоток для гонга"
	desc = "Подходит для стучания по гонгу."
	icon_state = "gongmallet"
	item_state = "gongmallet"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = WEAPON_FORCE_NORMAL + 2
	w_class = ITEM_SIZE_SMALL
	throwforce = WEAPON_FORCE_NORMAL
	throw_speed = 5
	throw_range = 5

	attack_verb = list("jabbed", "hit", "bashed")
	flammable = TRUE

/obj/item/weapon/whistle/tin
	name = "свисток"
	desc = "Свисток из металла."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "whistle"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_POCKET
	w_class = ITEM_SIZE_TINY

/obj/item/weapon/compass
	name = "compass"
	desc = "An instrument containing a magnetized pointer which shows the direction of magnetic north and bearings from it."
	icon = 'icons/obj/items.dmi'
	icon_state = "compass"
	slot_flags = SLOT_BELT | SLOT_POCKET | SLOT_ID
	w_class = ITEM_SIZE_TINY
	force = WEAPON_FORCE_HARMLESS
	throwforce = WEAPON_FORCE_HARMLESS
	var/time = 100
	var/max_offset = 6

/obj/item/weapon/compass/attack_self(mob/user as mob)
	var/offset = rand(-max_offset,max_offset)
	var/pos_x = user.x + offset
	var/pos_y = user.y + offset
	var/lat_x = round((world.maxx)/3)
	var/lat_y = round((world.maxy)/3)

	var/pos_dir_x = "-UNKNOWN"
	var/pos_dir_y = "UNKNOWN"

	var/pos_message = "You're in the [pos_dir_y][pos_dir_x] of the area."
	if (do_after(user,time,src))
		if (pos_x <= lat_x)
			pos_dir_x = "WEST"
		else if (pos_x >= 2*lat_x)
			pos_dir_x = "EAST"
		else
			pos_dir_x = ""

		if (pos_y <= lat_y)
			pos_dir_y = "SOUTH"
		else if (pos_y >= 2*lat_y)
			pos_dir_y = "NORTH"
		else
			pos_dir_y = ""

		if (pos_dir_x != "" || pos_dir_y != "")
			pos_message = "You're in the <b>[pos_dir_y][pos_dir_x]</b> of the area."
		else
			pos_message = "You're in the <b>CENTER</b> of the area."
		usr << "You estimate your position to be <b>[pos_x];[pos_y]</b>. [pos_message]"

/obj/item/weapon/compass/modern
	name = "navigation tablet"
	desc = "A tablet programmed specifically to navigate people through rough terrain and to let them know where they are."
	icon_state = "compass_modern"
	slot_flags = SLOT_BELT
	time = 3
	max_offset = 2
	secondary_action = TRUE
	var/on = FALSE

/obj/item/weapon/compass/modern/attack_self(mob/user as mob)
	if (!on)
		usr << "<span class = 'warning'>You need to turn the tablet on.</span>"
		return
	else
		. = ..()
/obj/item/weapon/compass/modern/secondary_attack_self(mob/living/human/user)
	turn_on()

/obj/item/weapon/compass/modern/proc/turn_on()
	if (!on)
		on = TRUE
		icon_state = "compass_modern_on"
		update_icon()
		return
	else
		on = FALSE
		icon_state = "compass_modern"
		update_icon()
		return

/obj/item/weapon/compass/modern/tacmap
	name = "tactical map"
	desc = "A tablet programmed specifically to navigate combatants through rough terrain and to let them know where they are."
	var/image/img

/obj/item/weapon/compass/modern/tacmap/New()
	..()
	switch (map.ID)
		if ("OPERATION_FALCON")
			img = image(icon = 'icons/minimaps.dmi', icon_state = "operation_falcon_map")

/obj/item/weapon/compass/modern/tacmap/examine(mob/user)
	user << browse(getFlatIcon(img),"window=popup;size=630x630")

//////////////////////////////////////////LOCKPICK/////////////////////////////////////////////////////////////////////////////
/obj/item/weapon/lockpick
	name = "отмычка"
	desc = "Вскрывает двери и замки, если вы умеете ей пользоваться."
	icon = 'icons/obj/items.dmi'
	icon_state = "lockpick"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_POCKET
	force = 5
	throwforce = WEAPON_FORCE_NORMAL
	w_class = ITEM_SIZE_TINY

	attack_verb = list("shanked", "jabbed", "stabbed","shiv'd")
