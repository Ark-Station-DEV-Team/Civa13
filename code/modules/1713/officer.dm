//ARTILLERY

#define kanonier_msg " Артиллерию, авиаудары и припасы теперь можно запросить в радиусе <b>15 метров</b> от точки."

var/global/list/valid_coordinates = list()
/mob/living/human/var/checking_coords[4]
/mob/living/human/var/can_check_distant_coordinates = FALSE

/mob/living/human/proc/make_artillery_officer()
	verbs += /mob/living/human/proc/Check_Coordinates
	verbs += /mob/living/human/proc/Reset_Coordinates
	can_check_distant_coordinates = TRUE

/mob/living/human/proc/make_artillery_scout()
	verbs += /mob/living/human/proc/Check_Coordinates_Chump
	verbs += /mob/living/human/proc/Reset_Coordinates_Chump
	can_check_distant_coordinates = TRUE

/mob/living/human/proc/make_artillery_radioman()
	verbs += /mob/living/human/proc/order_airstrike

/mob/living/human/proc/make_commander()
	verbs += /mob/living/human/proc/Commander_Announcement

/mob/living/human/proc/remove_commander()
	verbs -= /mob/living/human/proc/Commander_Announcement


/mob/living/human/proc/make_title_changer()
	verbs += /mob/living/human/proc/Add_Title
	verbs += /mob/living/human/proc/Remove_Title

/mob/living/human/proc/remove_title_changer()
	verbs -= /mob/living/human/proc/Add_Title
	verbs -= /mob/living/human/proc/Remove_Title


/proc/check_coords_check()
	return (!map || map.faction2_can_cross_blocks() || map.faction1_can_cross_blocks())

/mob/living/human/proc/find_nco()
	set category = "Лидер"
	set name = "Find Squad Leader"
	set desc = "Check where your squad leader is."

	if(!original_job.uses_squads || squad < 1)
		return
	var/mob/living/human/TSL = null
	if (faction_text == map.faction1)
		if (!map.faction1_squad_leaders[squad])
			src << "<big>Лидера нет!</big>"
			return
		else if (map.faction1_squad_leaders[squad] == src)
			src << "<big>Я лидер!</big>"
			return
		TSL = map.faction1_squad_leaders[squad]
	else if (faction_text == map.faction2)
		if (!map.faction2_squad_leaders[squad])
			src << "<big>Лидера нет!</big>"
			return
		else if (map.faction2_squad_leaders[squad] == src)
			src << "<big>Я лидер!</big>"
			return
		TSL = map.faction2_squad_leaders[squad]
	if (TSL)
		var/tdist = get_dist(src,TSL)
		var/tdir = dir2text(get_dir(src,TSL))
		src << "<big><font color='yellow'>Твой лидер в [tdist] метрах [tdir] тебя.</font></big>"
/mob/living/human/proc/Squad_Announcement()
	set category = "Лидер"
	set name = "Squad Announcement"
	set desc = "Сообщить всем в отряде."
	if (stat != DEAD)
		var/messaget = "Сообщение от лидера"
		var/message = input("Что сообщаем:", "Сообщение отряду", null, null)
		if (message)
			message = sanitize(message, 500, extra = FALSE)
			message = replacetext(message, "\n", "<br>") // required since we're putting it in a <p> tag
		for (var/mob/living/human/M)
			if (faction_text == M.faction_text && original_job.is_squad_leader && M.squad == squad && world.time > announcement_cooldown)
				messaget = "Лидер сообщает:"
				M.show_message("<big><span class=notice><b>[messaget]</b></big><p style='text-indent: 50px'>[message]</p></span>", 2)
		announcement_cooldown = world.time+600
		log_admin("Лидер сообщает: [key_name(usr)] - [messaget] : [message]")
	else
		usr << "Я мёртв!"

/mob/living/human/proc/Commander_Announcement()
	set category = "Лидер"
	set name = "Faction Announcement"
	set desc = "Оповещение от командования."
	if (stat != DEAD)
		var/messaget = "Announcement"
		var/message = input("Что сообщаем?", "Сообщение фракции", null, null)
		if (message && message != "")
			message = sanitize(message, 500, extra = FALSE)
			message = replacetext(message, "\n", "<br>") // required since we're putting it in a <p> tag
		for (var/mob/living/human/M)
			if (!map.civilizations)
				if (faction_text == M.faction_text)
					messaget = "[name] сообщает:"
					M.show_message("<big><span class=notice><b>[messaget]</b></big><p style='text-indent: 50px'>[message]</p></span>", 2)
				log_admin("Лидер фракции сообщает: [key_name(usr)] - [messaget] : [message]")
			else
				if (civilization == M.civilization && civilization != "none" && world.time > announcement_cooldown)
					messaget = "[name] сообщает:"
					M.show_message("<big><span class=notice><b>[messaget]</b></big><p style='text-indent: 50px'>[message]</p></span>", 2)
		announcement_cooldown = world.time+1800
		log_admin("Лидер фракции сообщает: [key_name(usr)] - [messaget] : [message]")
	else
		usr << "Я мёртв!"

/mob/living/human/proc/Check_Coordinates()
	set category = "Лидер"
	if (!check_coords_check())
		usr << "<span class = 'warning'>Я не умею!</span>"
		return
	if (checking_coords[1] && checking_coords[2])
		checking_coords[3] = x
		checking_coords[4] = y
		valid_coordinates["[x],[y]"] = TRUE
		var/dist = "[checking_coords[3] - checking_coords[1]],[checking_coords[4] - checking_coords[2]]"
		usr << "<span class = 'notice'>Вы закончили отслеживать координаты в <b>[x],[y]</b>. Вы переместились от отмеченой точки на <b>[dist]</b>.[kanonier_msg]</span>"
		checking_coords[3] = null
		checking_coords[4] = null // continue to track from the same starting location
	else
		checking_coords[1] = x
		checking_coords[2] = y
		usr << "<span class = 'notice'>Начинаю отслеживать координаты <b>[x], [y]</b>.</span>"

/mob/living/human/proc/Reset_Coordinates()
	set category = "Лидер"
	if (!check_coords_check())
		usr << "<span class = 'warning'>Я не умею!</span>"
		return
	if (checking_coords[1] && checking_coords[2])
		var/x = checking_coords[1]
		var/y = checking_coords[2]
		checking_coords[1] = null
		checking_coords[2] = null
		usr << "<span class = 'notice'>Перестаю отслеживать координаты <b>[x],[y]</b>.</span>"
		checking_coords[3] = null
		checking_coords[4] = null

// the only thing different about these verbs is the category

/mob/living/human/proc/Check_Coordinates_Chump()
	set category = "Scout"
	set name = "Check Coordinates"
	if (!check_coords_check())
		usr << "<span class = 'warning'>Я не умею!</span>"
		return
	if (checking_coords[1] && checking_coords[2])
		checking_coords[3] = x
		checking_coords[4] = y
		valid_coordinates["[x],[y]"] = TRUE
		var/dist = "[checking_coords[3] - checking_coords[1]],[checking_coords[4] - checking_coords[2]]"
		usr << "<span class = 'notice'>Заканчиваю следить за <b>[x],[y]</b>. Я переместился на <b>[dist]</b> от точки.[kanonier_msg]</span>"
		checking_coords[3] = null
		checking_coords[4] = null // continue to track from the same starting location
	else
		checking_coords[1] = x
		checking_coords[2] = y
		usr << "<span class = 'notice'>Слежу за <b>[x],[y]</b>.</span>"

/mob/living/human/proc/Reset_Coordinates_Chump()
	set category = "Scout"
	set name = "Reset Coordinates"
	if (!check_coords_check())
		usr << "<span class = 'warning'>Я не умею!</span>"
		return
	if (checking_coords[1] && checking_coords[2])
		var/x = checking_coords[1]
		var/y = checking_coords[2]
		checking_coords[1] = null
		checking_coords[2] = null
		usr << "<span class = 'warning'>Перестаю следить за <b>[x],[y]</b>.</span>"
		checking_coords[3] = null
		checking_coords[4] = null

// artyman/officer/scout getting coordinates
/mob/living/human/RangedAttack(var/turf/t)
	if (checking_coords[1] && istype(t))
		if (can_check_distant_coordinates && get_turf(src) != t)
			var/offset_x = t.x - x
			var/offset_y = t.y - y
			src << "<span class = 'notice'>Эта местность имеет смещение <b>[offset_x],[offset_y]</b> от <b>[t.x],[t.y]</b>.[kanonier_msg]</span>"
			valid_coordinates["[t.x],[t.y]"] = TRUE
	else
		return ..()

//OTHER



/mob/living/human/proc/order_airstrike()
	set category = "Лидер"
	set name = "Order Airstrike"
	var/icon/radio
	var/currfreq = 0
	for (var/obj/structure/radio/R in range(1,src))
		if (!radio)
			radio = getFlatIcon(R)
			currfreq = R.freq
	for (var/obj/item/weapon/radio/R in range(1,src))
		if (!radio)
			radio = getFlatIcon(R)
			currfreq = R.freq
	if (currfreq == 0)
		src << "<span class='notice'>Нет радио!</span>"
		return
	if (src.stat == DEAD)	
		src << SPAN_WARNING("You're dead!")
		return
	if (map.artillery_count > 0 && world.time >= map.artillery_last+map.artillery_timer)
		var/list/validchoices = map.valid_artillery
		var/valid_coords_check = FALSE
		validchoices += "Cancel"
		if (map.ID != "GROZNY")
			var/input1 = WWinput(src, "Чем хуярим?", "Order Airstrike", "Cancel", validchoices)
			if (input1 == "Cancel")
				return
			else
				var/inputx = input(src, "Координаты по X оси:") as num
				if (inputx > world.maxx)
					inputx = world.maxx
				if (inputx < 0)
					inputx = 1
				var/inputy = input(src, "Координаты по Y оси:") as num
				if (inputy > world.maxy)
					inputy = world.maxy
				if (inputy < 0)
					inputy = 1
				if (global.valid_coordinates.Find("[inputx],[inputy]"))
					valid_coords_check = TRUE
				else
					for (var/coords in global.valid_coordinates)
						var/splitcoords = splittext(coords, ",")
						var/coordx = text2num(splitcoords[1])
						var/coordy = text2num(splitcoords[2])
						if (abs(coordx - inputx) <= 15)
							if (abs(coordy - inputy) <= 15)
								valid_coords_check = TRUE
				if (!valid_coords_check)
					src << "\icon[radio] <font size=2 color=#FFAE19><b>Центральное командование, [currfreq]kHz:</font></b><font size=2]> <span class = 'small_message'>([default_language.name])</span> \"[name] мы не получили координат от офицера или разведчика. Отказ.\"</font>"
					return
				for (var/mob/living/human/friendlies in range(7, locate(inputx,inputy,src.z)))
					if (friendlies.faction_text == faction_text && friendlies.stat != DEAD)
						src << "\icon[radio] <font size=2 color=#FFAE19><b>Центральное командование, [currfreq]kHz:</font></b><font size=2]> <span class = 'small_message'>([default_language.name])</span> \"[name] мы обнаружили дружественых союзников или наших солдат на отмеченой точке. Отказ.\"</font>"
						return
				src << "\icon[radio] <font size=2 color=#FFAE19><b>Центральное командование, [currfreq]kHz:</font></b><font size=2> <span class = 'small_message'>([default_language.name])</span> \"Принято [name], идёт обстрел [inputx],[inputy]. Тип боеприпасов: [input1].\"</font>"
				map.artillery_count--
				map.artillery_last = world.time
				spawn(rand(15,25)*10)
					airstrike(input1,inputx,inputy,src.z)
				message_admins("[key_name_admin(src)] ordered an [input1] airstrike at ([inputx],[inputy],[src.z]).", key_name_admin(src))
				log_game("[key_name_admin(src)] ordered an [input1] airstrike at ([inputx],[inputy],[src.z]).")
				return
		else
			var/input1 = WWinput(src, "Куда наводим?", "Order Artillery Barrage", "Cancel", validchoices)
			if (input1 == "Cancel")
				return
			else
				var/inputx = input(src, "Координаты по X оси:") as num
				if (inputx > world.maxx)
					inputx = world.maxx
				if (inputx < 0)
					inputx = 1
				var/inputy = input(src, "Координаты по Y оси:") as num
				if (inputy > world.maxy)
					inputy = world.maxy
				if (inputy < 0)
					inputy = 1
				if (global.valid_coordinates.Find("[inputx],[inputy]"))
					valid_coords_check = TRUE
				else
					for (var/coords in global.valid_coordinates)
						var/splitcoords = splittext(coords, ",")
						var/coordx = text2num(splitcoords[1])
						var/coordy = text2num(splitcoords[2])
						if (abs(coordx - inputx) <= 15)
							if (abs(coordy - inputy) <= 15)
								valid_coords_check = TRUE
				if (!valid_coords_check)
					src << "\icon[radio] <font size=2 color=#FFAE19><b>Артилерийское тыловое командование, [currfreq]kHz:</font></b><font size=2]> <span class = 'small_message'>([default_language.name])</span> \"Отказ, [name]. Повторяю, отказ. Мы не получили координат для обстрела.\"</font>"
					return
				for (var/mob/living/human/friendlies in range(7, locate(inputx,inputy,src.z)))
					if (friendlies.faction_text == faction_text && friendlies.stat != DEAD)
						src << "\icon[radio] <font size=2 color=#FFAE19><b>Артилерийское тыловое командование, [currfreq]kHz:</font></b><font size=2]> <span class = 'small_message'>([default_language.name])</span> \"Отказ. [name], Повторяю, отказ. В данной области мы обнаружили союзные силы, смените точку.\"</font>"
						return
				src << "\icon[radio] <font size=2 color=#FFAE19><b>Артилерийское тыловое командование, [currfreq]kHz:</font></b><font size=2> <span class = 'small_message'>([default_language.name])</span> \"Вас понял, [name]. Начинаем обстрел по координатам [inputx],[inputy]. Тип боеприпасов: [input1].\"</font>"
				map.artillery_count--
				map.artillery_last = world.time
				spawn(rand(15,25)*10)
					airstrike(input1,inputx,inputy,src.z)
				message_admins("[key_name_admin(src)] ordered an [input1] artillery at ([inputx],[inputy],[src.z]).", key_name_admin(src))
				log_game("[key_name_admin(src)] ordered an [input1] artillery at ([inputx],[inputy],[src.z]).")
				return
	else if (map.artillery_count <= 0)
		map.artillery_count = 0
		if (map.ID != "GROZNY")
			src << "<span class='warning'>Авиаудары исчерпаны.</span>"
			return
		else
			src << "<span class='warning'>Артилерия не может больше помочь.</span>"
			return
	else if (world.time < map.artillery_last+map.artillery_timer)
		if (map.ID != "GROZNY")
			src << "<span class='warning'>Подожди [round(((map.artillery_last+map.artillery_timer)-world.time)/600)] минут для запроса авиаудара.</span>"
			return
		else
			src << "<span class='warning'>Батарея на перезарядке - подожди [round(((map.artillery_last+map.artillery_timer)-world.time)/600)] минут.</span>"
			return
/mob/living/human/proc/airstrike(var/type, var/inputx, var/inputy, var/inputz)
	var/turf/T = get_turf(locate(inputx,inputy,inputz))
	if (!T)
		return
	if (type == "White Phosphorus")
		new/obj/effect/effect/smoke/chem/payload/white_phosphorus_gas(T)
	else if (type == "Explosive")
		if (map.ID != "GROZNY")
			var/xoffsetmin = inputx-6
			var/xoffsetmax = inputx+6
			var/yoffsetmin = inputy-6
			var/yoffsetmax = inputy+6
			for (var/i = 1, i < 6, i++)
				var/turf/O = get_turf(locate(rand(xoffsetmin,xoffsetmax),rand(yoffsetmin,yoffsetmax),inputz))
				explosion(O,1,1,3,1)
		else
			var/xoffsetmin = inputx-6
			var/xoffsetmax = inputx+6
			var/yoffsetmin = inputy-6
			var/yoffsetmax = inputy+6
			for (var/i = 1, i < 12, i++)
				var/turf/O = get_turf(locate(rand(xoffsetmin,xoffsetmax),rand(yoffsetmin,yoffsetmax),inputz))
				explosion(O,1,1,3,1)
	else if (type == "Creeping Barrage")
		var/xoffsetmin = inputx-6
		var/xoffsetmax = inputx+6
		var/yoffsetmin = inputy
		var/yoffsetmax = inputy
		for (var/i = 1, i < 12, i++)
			var/turf/O = get_turf(locate(rand(xoffsetmin,xoffsetmax),rand(yoffsetmin,yoffsetmax),inputz))
			explosion(O,1,1,3,1)
			spawn(20)
				xoffsetmin = inputx-6
				xoffsetmax = inputx+6
				yoffsetmin = inputy-1
				yoffsetmax = inputy-3
				O = get_turf(locate(rand(xoffsetmin,xoffsetmax),rand(yoffsetmin,yoffsetmax),inputz))
				explosion(O,1,1,3,1)
				spawn(20)
					xoffsetmin = inputx-6
					xoffsetmax = inputx+6
					yoffsetmin = inputy-3
					yoffsetmax = inputy-5
					O = get_turf(locate(rand(xoffsetmin,xoffsetmax),rand(yoffsetmin,yoffsetmax),inputz))
					explosion(O,1,1,3,1)
					spawn(20)
						xoffsetmin = inputx-6
						xoffsetmax = inputx+6
						yoffsetmin = inputy-5
						yoffsetmax = inputy-7
						O = get_turf(locate(rand(xoffsetmin,xoffsetmax),rand(yoffsetmin,yoffsetmax),inputz))
						explosion(O,1,1,3,1)
						spawn(20)
							xoffsetmin = inputx-6
							xoffsetmax = inputx+6
							yoffsetmin = inputy-7
							yoffsetmax = inputy-10
							O = get_turf(locate(rand(xoffsetmin,xoffsetmax),rand(yoffsetmin,yoffsetmax),inputz))
							explosion(O,1,1,3,1)
							spawn(20)
								xoffsetmin = inputx-6
								xoffsetmax = inputx+6
								yoffsetmin = inputy-9
								yoffsetmax = inputy-11
								O = get_turf(locate(rand(xoffsetmin,xoffsetmax),rand(yoffsetmin,yoffsetmax),inputz))
								explosion(O,1,1,3,1)

	else if (type == "Napalm")
		var/xoffsetmin = inputx-7
		var/xoffsetmax = inputx+7
		var/yoffsetmin = inputy-7
		var/yoffsetmax = inputy+7
		for (var/i = 1, i < 6, i++)
			var/turf/O = get_turf(locate(rand(xoffsetmin,xoffsetmax),rand(yoffsetmin,yoffsetmax),inputz))
			explosion(O,0,1,1,3)
			for (var/mob/living/LS1 in O)
				LS1.adjustBurnLoss(35)
				LS1.fire_stacks += rand(8,10)
				LS1.IgniteMob()
			new/obj/effect/fire(O)
		spawn(10)
			xoffsetmin = inputx-4
			xoffsetmax = inputx+4
			yoffsetmin = inputy-4
			yoffsetmax = inputy+4
			for (var/i = 1, i < 18, i++)
				var/turf/O = get_turf(locate(rand(xoffsetmin,xoffsetmax),rand(yoffsetmin,yoffsetmax),inputz))
				for (var/mob/living/LS1 in O)
					LS1.adjustBurnLoss(14)
					LS1.fire_stacks += rand(2,4)
					LS1.IgniteMob()
				new/obj/effect/fire(O)

////FBI COMMAND TO FIND HVT

/mob/living/human/proc/find_hvt()
	set category = "Лидер"
	set name = "Locate HVT"
	set desc = "Check where the HVT is."

	var/count = 0
	for (var/mob/living/human/H in player_list)
		if (H.original_job_title == ("Soviet Supreme Chairman" || "US HVT"))
			var/tdist = get_dist(src,H)
			var/tdir = dir2text_ru(get_dir(src,H))
			count++
			src << "<big><font color='yellow'>The <b>HVT</b> (<i>[H.name]</i>) в [tdist] метрах [tdir] тебя.</font></big>"
	if (count <= 0)
		src << "<big><font color='yellow'><b>HVT</b> не обнаружены!</font></big>"