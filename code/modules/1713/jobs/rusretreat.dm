/////////Chechen Army//////////////

/datum/job/arab/civilian/chechen/give_random_name(var/mob/living/human/H)
	H.name = H.species.get_random_chechen_name(H.gender)
	H.real_name = H.name
	H.circumcised = TRUE


/datum/job/arab/civilian/chechen/leader
	title = "Chechnyan Warlord"
	en_meaning = "Warlord"
	rank_abbreviation = "W."
	spawn_location = "JoinLateCCWL"
	is_rusretreat = TRUE
	is_commander = TRUE
	is_ww2 = FALSE
	is_modernday = TRUE
	whitelisted = TRUE

	min_positions = 1
	max_positions = 3

/datum/job/arab/civilian/chechen/leader/equip(var/mob/living/human/H)

//shoes
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/toughguy(H), slot_shoes)

//clothes
	H.equip_to_slot_or_del(new /obj/item/clothing/head/ww/papakha(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/insurgent_leader(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/b3(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/smokable/cigarette/cigar(H), slot_wear_mask)
	H.equip_to_slot_or_del(new /obj/item/weapon/radio/walkietalkie/faction1(H), slot_wear_id)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/toughguy(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/military(H), slot_l_store)

//back
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/pistol/tt30(H), slot_l_hand)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/submachinegun/ak74/aks74/aks74u/aks74uso/kgb(H), slot_shoulder)


	H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/duffel(H), slot_back)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/smallpouches/green/chechoff(H), slot_belt)
	var/obj/item/clothing/under/uniform = H.w_uniform
	var/obj/item/clothing/accessory/armor/coldwar/plates/interceptor/armor = new /obj/item/clothing/accessory/armor/coldwar/plates/interceptor(null)
	uniform.attackby(armor, H)
	var/obj/item/clothing/accessory/holster/hip/holsterh = new /obj/item/clothing/accessory/holster/hip(null)
	uniform.attackby(holsterh, H)


	H.f_style = pick("Full Beard","Medium Beard","Long Beard","Abraham Lincoln Beard","Neckbeard","Selleck Mustache")
	H.h_style = pick("Bald","Crewcut","Undercut","Short Hair","Cut Hair","Skinhead","Average Joe","Fade","Combover","Father","Parted","Shoulder-length Hair")

	var/new_hair = pick("Dark Brown","Black","Orange","Grey")
	var/hex_hair = hair_colors[new_hair]
	H.r_hair = hex2num(copytext(hex_hair, 2, 4))
	H.g_hair = hex2num(copytext(hex_hair, 4, 6))
	H.b_hair = hex2num(copytext(hex_hair, 6, 8))
	H.r_facial = hex2num(copytext(hex_hair, 2, 4))
	H.g_facial = hex2num(copytext(hex_hair, 4, 6))
	H.b_facial = hex2num(copytext(hex_hair, 6, 8))

	H.civilization = "Militia"
	give_random_name(H)
	H.add_note("Role", "You are a Warlord! Organize the militia and fend off the russian invaders!")
	H.setStat("strength", STAT_MEDIUM_HIGH)
	H.setStat("crafting", STAT_NORMAL)
	H.setStat("rifle", STAT_HIGH)
	H.setStat("dexterity", STAT_MEDIUM_HIGH)
	H.setStat("swords", STAT_HIGH)
	H.setStat("pistol", STAT_MEDIUM_HIGH)
	H.setStat("bows", STAT_NORMAL)
	H.setStat("medical", STAT_MEDIUM_LOW)
	H.setStat("machinegun", STAT_NORMAL)
	return TRUE

/datum/job/arab/civilian/chechen/militia
	title = "Chechen Militia"
	en_meaning = "Chechnyan Armed Militia"
	rank_abbreviation = ""
	spawn_location = "JoinLateCC"
	min_positions = 10
	max_positions = 200
	is_rusretreat = TRUE
	is_modernday = TRUE

/datum/job/arab/civilian/chechen/militia/equip(var/mob/living/human/H)

//shoes
	var/randshoe2 = rand(1,5)
	if (randshoe2 == 1)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(H), slot_shoes)
	else if (randshoe2 == 2)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/workboots(H), slot_shoes)
	else if (randshoe2 == 3)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
	else if (randshoe2 == 4)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/leatherboots1(H), slot_shoes)
	else if (randshoe2 == 5)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/winterboots(H), slot_shoes)


//clothes
	var/randjack2 = rand(1,10)
	if (randjack2 == 1)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/insurgent_black(H), slot_w_uniform)
	else if (randjack2 == 2)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/insurgent_sand(H), slot_w_uniform)
	else if (randjack2 == 3)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/insurgent_sand_dcu(H), slot_w_uniform)
	else if (randjack2 == 4)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/insurgent_sand_green(H), slot_w_uniform)
	else if (randjack2 == 5)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/oldmansuit(H), slot_w_uniform)
	else if (randjack2 == 6)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/engi(H), slot_w_uniform)
	else if (randjack2 == 7)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/insurgent_sand_woodland(H), slot_w_uniform)
	else if (randjack2 == 8)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/mafia(H), slot_w_uniform)
	else if (randjack2 == 9)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/ww2/civ1(H), slot_w_uniform)
	else if (randjack2 == 10)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/ww2/civ2(H), slot_w_uniform)


//head
	var/randhead2 = rand(1,6)
	switch(randhead2)
		if (1)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/ww/papakha(H), slot_head)
		if (2)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/flatcap1(H), slot_head)
		if (3)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/ww/adriansoviet(H), slot_head)
		if (4)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/ww/papakha/white(H), slot_head)
		if (5)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/commando_bandana(H), slot_head)
		if (6)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/modern/ssh_68(H), slot_head)

//gloves
	var/randglove2 = rand(1,4)
	switch(randglove2)
		if (1)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/thick/leather(H), slot_gloves)
		if (2)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/fingerless(H), slot_gloves)
		if (3)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/watch/watch(H), slot_gloves)
		if (4)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/watch/specialwatch(H), slot_gloves)


//misc
	var/randmisc2 = rand(1,6)
	switch(randmisc2)
		if (1)
			H.equip_to_slot_or_del(new /obj/item/clothing/glasses/pilot(H), slot_eyes)
		if (2)
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/shemagh/greykerchief(H), slot_wear_mask)
		if (3)
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/shemagh/redkerchief(H), slot_wear_mask)
		if (4)
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/smokable/cigarette(H), slot_wear_mask)
		if (5)
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/smokable/cigarette/cigar(H), slot_wear_mask)
		if (6)
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/smokable/cigarette(H), slot_wear_mask)

//weapon
	var/randarmw = rand(1,3)
	switch(randarmw)
		if (1)
			if (prob(75))
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/submachinegun/vz58(H), slot_l_hand)
			else
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/pkm(H), slot_l_hand)

		if (2)
			if (prob(60))
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/submachinegun/ak74(H), slot_l_hand)
			else
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/submachinegun/ak74/aks74/aks74u/aks74uso(H), slot_l_hand)
		if (3)
			if (prob(75))
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/submachinegun/ak47(H), slot_l_hand)
			else
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/submachinegun/ak47/akms(H), slot_l_hand)

//vodka
	if (prob(15))
		H.equip_to_slot_or_del(new /obj/item/weapon/reagent_containers/food/drinks/bottle/vodka(H), slot_r_hand)

	var/randsword2 = rand(1,3)
	switch(randsword2)
		if (1)
			H.equip_to_slot_or_del(new /obj/item/weapon/material/machete(H), slot_belt)
		if (2)
			H.equip_to_slot_or_del(new /obj/item/weapon/material/sword/shashka(H), slot_belt)
		if (3)
			H.equip_to_slot_or_del(new /obj/item/weapon/material/kitchen/utensil/knife/tacticalknife(H), slot_belt)

	var/obj/item/clothing/under/uniform = H.w_uniform
	var/obj/item/clothing/accessory/armor/modern/plate/armor = new /obj/item/clothing/accessory/armor/modern/plate(null)
	uniform.attackby(armor, H)

//suit
	var/randsuits = rand(1,6)
	if (randsuits == 1)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/coat/ww2/biker/lizard_jacket(H), slot_wear_suit)
	else if (randsuits == 2)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/coat/ww2/bomberjacketbrown(H), slot_wear_suit)
	else if (randsuits == 3)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/b3(H), slot_wear_suit)
	else if (randsuits == 4)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/coat/ww2/expensivecoat(H), slot_wear_suit)
	else if (randsuits == 5)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/coat/ww2/sovcoat2(H), slot_wear_suit)
	else if (randsuits == 6)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/coat/ww2/sovcoat(H), slot_wear_suit)

	H.equip_to_slot_or_del(new /obj/item/weapon/radio/walkietalkie/faction1(H), slot_wear_id)

//back
	if (prob(33))
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)

	H.f_style = pick("Full Beard","Medium Beard","Long Beard","Abraham Lincoln Beard","Neckbeard","Selleck Mustache")
	H.h_style = pick("Bald","Crewcut","Undercut","Short Hair","Cut Hair","Skinhead","Average Joe","Fade","Combover","Father","Parted","Shoulder-length Hair")

	var/new_hair = pick("Dark Brown","Black","Orange","Grey")
	var/hex_hair = hair_colors[new_hair]
	H.r_hair = hex2num(copytext(hex_hair, 2, 4))
	H.g_hair = hex2num(copytext(hex_hair, 4, 6))
	H.b_hair = hex2num(copytext(hex_hair, 6, 8))
	H.r_facial = hex2num(copytext(hex_hair, 2, 4))
	H.g_facial = hex2num(copytext(hex_hair, 4, 6))
	H.b_facial = hex2num(copytext(hex_hair, 6, 8))

	H.add_note("Role", "You are a <b>[title]</b> insurging against the Russian occupants! Do all it takes to prevent them from crossing the bridge south of the city and listen to your Warlords!")
	H.civilization = "Militia"
	give_random_name(H)
	H.setStat("strength", STAT_NORMAL)
	H.setStat("crafting", STAT_NORMAL)
	H.setStat("rifle", STAT_NORMAL)
	H.setStat("dexterity", STAT_NORMAL)
	H.setStat("swords", STAT_MEDIUM_HIGH)
	H.setStat("pistol", STAT_NORMAL)
	H.setStat("bows", STAT_NORMAL)
	H.setStat("medical", STAT_LOW)
	H.setStat("machinegun", STAT_NORMAL)
	return TRUE

/datum/job/arab/civilian/chechen/medic
	title = "Chechnyan Militia Medic"
	en_meaning = "Medic"
	rank_abbreviation = "Dr."

	spawn_location = "JoinLateCC"

	is_medic = TRUE
	is_rusretreat = TRUE
	is_modernday = TRUE
	is_ww2 = FALSE

	min_positions = 3
	max_positions = 10

/datum/job/arab/civilian/chechen/equip(var/mob/living/human/H)

//shoes
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(H), slot_shoes)

//clothes
	H.equip_to_slot_or_del(new /obj/item/clothing/under/insurgent_black(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/doctor(H), slot_wear_suit)

//head
	H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/ww2/adrianm26medic(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/sterile(H), slot_wear_mask)
//back
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/firstaid/adv(H), slot_back)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/firstaid/combat/modern(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/firstaid/surgery(H), slot_l_hand)
	H.equip_to_slot_or_del(new /obj/item/weapon/radio/walkietalkie/faction1(H), slot_wear_id)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/color/white(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/revolver/smithwesson(H), slot_r_store)

	var/obj/item/clothing/under/uniform = H.w_uniform
	var/obj/item/clothing/accessory/armor/coldwar/plates/interceptor/armor = new /obj/item/clothing/accessory/armor/coldwar/plates/interceptor(null)
	uniform.attackby(armor, H)
	var/obj/item/clothing/accessory/holster/hip/holsterh = new /obj/item/clothing/accessory/holster/hip(null)
	uniform.attackby(holsterh, H)

	H.f_style = pick("Full Beard","Medium Beard","Long Beard","Abraham Lincoln Beard","Neckbeard","Selleck Mustache")
	H.h_style = pick("Bald","Crewcut","Undercut","Short Hair","Cut Hair","Skinhead","Average Joe","Fade","Combover","Father","Parted","Shoulder-length Hair")

	var/new_hair = pick("Dark Brown","Black","Orange","Grey")
	var/hex_hair = hair_colors[new_hair]
	H.r_hair = hex2num(copytext(hex_hair, 2, 4))
	H.g_hair = hex2num(copytext(hex_hair, 4, 6))
	H.b_hair = hex2num(copytext(hex_hair, 6, 8))
	H.r_facial = hex2num(copytext(hex_hair, 2, 4))
	H.g_facial = hex2num(copytext(hex_hair, 4, 6))
	H.b_facial = hex2num(copytext(hex_hair, 6, 8))

	H.add_note("Role", "You are a <b>[title]</b>. Keep your brothers healthy and motivated!")
	H.civilization = "Militia"
	give_random_name(H)
	H.setStat("strength", STAT_NORMAL)
	H.setStat("crafting", STAT_NORMAL)
	H.setStat("rifle", STAT_MEDIUM_LOW)
	H.setStat("dexterity", STAT_HIGH)
	H.setStat("swords", STAT_NORMAL)
	H.setStat("pistol", STAT_NORMAL)
	H.setStat("bows", STAT_NORMAL)
	H.setStat("medical", STAT_VERY_HIGH)
	H.setStat("machinegun", STAT_MEDIUM_LOW)
	return TRUE

/////////Russian Federal Forces//////////////

/datum/job/russian/ruff_lieutenant
	title = "Russian Federal Forces Lieutenant"
	rank_abbreviation = "Lt."

	spawn_location = "JoinLateRUCap"

	is_rusretreat = TRUE
	is_officer = TRUE
	is_commander = TRUE
	is_modernday = TRUE
	is_ww2 = FALSE
	whitelisted = TRUE

	min_positions = 1
	max_positions = 3

/datum/job/russian/ruff_lieutenant/equip(var/mob/living/human/H)
	if (!H)	return FALSE
//shoes
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)

//clothes
	H.equip_to_slot_or_del(new /obj/item/clothing/under/milrus_vsr93(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/thick/swat/officer(H), slot_gloves)
//head
	H.equip_to_slot_or_del(new /obj/item/clothing/head/beret_rus_vdv(H), slot_head)


	H.equip_to_slot_or_del(new /obj/item/weapon/radio/walkietalkie/faction2(H), slot_wear_id)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/special/ak74mtactical(H), slot_shoulder)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/pistol/tt30(H), slot_l_hand)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/smallpouches/green/rusoff(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/russia(H), slot_r_store)
	var/obj/item/clothing/under/uniform = H.w_uniform
	var/obj/item/clothing/accessory/holster/hip/holsterh = new /obj/item/clothing/accessory/holster/hip(null)
	uniform.attackby(holsterh, H)
	var/obj/item/clothing/accessory/armor/coldwar/platecarriergreen/armour = new /obj/item/clothing/accessory/armor/coldwar/platecarriergreen(null)
	uniform.attackby(armour, H)
//jacket
	if (prob(15))
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/rus_winter_vsr93(H), slot_wear_suit)


	H.f_style = pick("Full Beard","Goatee","Selleck Mustache","Shaved")
	H.h_style = pick("Bald","Crewcut","Undercut","Short Hair","Cut Hair","Skinhead","Average Joe","Fade","Combover","Father")

	var/new_hair = pick("Red","Orange","Light Blond","Blond","Dirty Blond","Light Brown","Grey")
	var/hex_hair = hair_colors[new_hair]
	H.r_hair = hex2num(copytext(hex_hair, 2, 4))
	H.g_hair = hex2num(copytext(hex_hair, 4, 6))
	H.b_hair = hex2num(copytext(hex_hair, 6, 8))
	H.r_facial = hex2num(copytext(hex_hair, 2, 4))
	H.g_facial = hex2num(copytext(hex_hair, 4, 6))
	H.b_facial = hex2num(copytext(hex_hair, 6, 8))

	H.civilization = "Russian"
	give_random_name(H)
	H.add_note("Role", "You are a <b>[title]</b>. You are in charge of the whole platoon. Organize your troops accordingly!")
	H.setStat("strength", STAT_MEDIUM_HIGH)
	H.setStat("crafting", STAT_MEDIUM_HIGH)
	H.setStat("rifle", STAT_HIGH)
	H.setStat("dexterity", STAT_MEDIUM_HIGH)
	H.setStat("swords", STAT_NORMAL)
	H.setStat("pistol", STAT_HIGH)
	H.setStat("bows", STAT_NORMAL)
	H.setStat("medical", STAT_NORMAL)
	H.setStat("machinegun", STAT_NORMAL)
	return TRUE

/datum/job/russian/ruff_sergeant
	title = "Russian Federal Forces Sergeant"
	rank_abbreviation = "Sgt."

	spawn_location = "JoinLateRUSgt"

	is_rusretreat = TRUE
	is_modernday = TRUE
	is_ww2 = FALSE
	is_squad_leader = TRUE
	uses_squads = TRUE

	can_get_coordinates = TRUE

	min_positions = 2
	max_positions = 8

/datum/job/russian/ruff_sergeant/equip(var/mob/living/human/H)
	if (!H)	return FALSE

//shoes
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)

//clothes
	H.equip_to_slot_or_del(new /obj/item/clothing/under/milrus_vsr93(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/thick/combat(H), slot_gloves)
//head
	if (prob(33))
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/modern/sovietfacehelmet(H), slot_head)
	else
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/modern/a6b47(H), slot_head)
//back
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/special/ak74mtactical(H), slot_shoulder)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/pistol/tt30(H), slot_l_hand)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/smallpouches/green/rusoff(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/russia(H), slot_r_store)
	H.equip_to_slot_or_del(new /obj/item/weapon/radio/walkietalkie/faction2(H), slot_wear_id)
	var/obj/item/clothing/under/uniform = H.w_uniform
	var/obj/item/clothing/accessory/holster/hip/holsterh = new /obj/item/clothing/accessory/holster/hip(null)
	uniform.attackby(holsterh, H)
	var/obj/item/clothing/accessory/armor/coldwar/platecarriergreen/armour = new /obj/item/clothing/accessory/armor/coldwar/platecarriergreen(null)
	uniform.attackby(armour, H)

	if (prob(25))
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/rucksack(H), slot_back)
//jacket
	if (prob(33))
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/rus_winter_vsr93(H), slot_wear_suit)


	H.f_style = pick("Goatee","Selleck Mustache","Shaved")
	H.h_style = pick("Bald","Crewcut","Undercut","Short Hair","Cut Hair","Skinhead","Average Joe","Fade","Combover","Father")

	var/new_hair = pick("Red","Orange","Light Blond","Blond","Dirty Blond","Light Brown","Grey")
	var/hex_hair = hair_colors[new_hair]
	H.r_hair = hex2num(copytext(hex_hair, 2, 4))
	H.g_hair = hex2num(copytext(hex_hair, 4, 6))
	H.b_hair = hex2num(copytext(hex_hair, 6, 8))
	H.r_facial = hex2num(copytext(hex_hair, 2, 4))
	H.g_facial = hex2num(copytext(hex_hair, 4, 6))
	H.b_facial = hex2num(copytext(hex_hair, 6, 8))

	H.civilization = "Russian"
	give_random_name(H)
	H.add_note("Role", "You are a <b>[title]</b>, lead your squad against the chechen insurgents!")
	H.setStat("strength", STAT_MEDIUM_HIGH)
	H.setStat("crafting", STAT_MEDIUM_HIGH)
	H.setStat("rifle", STAT_MEDIUM_HIGH)
	H.setStat("dexterity", STAT_NORMAL)
	H.setStat("swords", STAT_NORMAL)
	H.setStat("pistol", STAT_MEDIUM_HIGH)
	H.setStat("bows", STAT_LOW)
	H.setStat("medical", STAT_MEDIUM_LOW)
	H.setStat("machinegun", STAT_MEDIUM_HIGH)
	return TRUE


/datum/job/russian/ruff_medic
	title = "Russian Federal Forces Corpsman"
	rank_abbreviation = "Pfc."

	spawn_location = "JoinLateRUMedic"

	is_medic = TRUE
	is_rusretreat = TRUE
	is_modernday = TRUE
	is_ww2 = FALSE

	min_positions = 2
	max_positions = 8

/datum/job/russian/ruff_medic/equip(var/mob/living/human/H)
	if (!H)	return FALSE
//shoes
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)

//clothes
	if (prob(60))
		H.equip_to_slot_or_del(new /obj/item/clothing/under/milrus_vsr93(H), slot_w_uniform)
		if (prob(15))
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/rus_winter_vsr93(H), slot_wear_suit)
	else
		H.equip_to_slot_or_del(new /obj/item/clothing/under/afghanka(H), slot_w_uniform)
		if (prob(15))
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/afghanka(H), slot_wear_suit)
//head
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/sterile(H), slot_wear_mask)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/ww2/soviet_medic(H), slot_head)
//back
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/firstaid/adv(H), slot_back)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/firstaid/combat/modern(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/pistol/tt30(H), slot_l_hand)

	H.equip_to_slot_or_del(new /obj/item/weapon/radio/walkietalkie/faction2(H), slot_wear_id)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/color/white(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/russia(H), slot_r_store)
	var/obj/item/clothing/under/uniform = H.w_uniform
	var/obj/item/clothing/accessory/custom/armband/white = new /obj/item/clothing/accessory/custom/armband(null)
	uniform.attackby(white, H)
	var/obj/item/clothing/accessory/holster/hip/holsterh = new /obj/item/clothing/accessory/holster/hip(null)
	uniform.attackby(holsterh, H)
	var/obj/item/clothing/accessory/armor/coldwar/platecarriergreen/armour = new /obj/item/clothing/accessory/armor/coldwar/platecarriergreen(null)
	uniform.attackby(armour, H)


	H.f_style = pick("Goatee","Selleck Mustache","Shaved")
	H.h_style = pick("Bald","Crewcut","Undercut","Short Hair","Cut Hair","Skinhead","Average Joe","Fade","Combover","Father")

	var/new_hair = pick("Red","Orange","Light Blond","Blond","Dirty Blond","Light Brown")
	var/hex_hair = hair_colors[new_hair]
	H.r_hair = hex2num(copytext(hex_hair, 2, 4))
	H.g_hair = hex2num(copytext(hex_hair, 4, 6))
	H.b_hair = hex2num(copytext(hex_hair, 6, 8))
	H.r_facial = hex2num(copytext(hex_hair, 2, 4))
	H.g_facial = hex2num(copytext(hex_hair, 4, 6))
	H.b_facial = hex2num(copytext(hex_hair, 6, 8))

	H.civilization = "Russian"
	give_random_name(H)
	H.add_note("Role", "You are a <b>[title]</b>. Keep your fellow soldiers healthy and alive!")
	H.setStat("strength", STAT_NORMAL)
	H.setStat("crafting", STAT_NORMAL)
	H.setStat("rifle", STAT_NORMAL)
	H.setStat("dexterity", STAT_NORMAL)
	H.setStat("swords", STAT_MEDIUM_LOW)
	H.setStat("pistol", STAT_NORMAL)
	H.setStat("bows", STAT_LOW)
	H.setStat("medical", STAT_VERY_HIGH)
	H.setStat("machinegun", STAT_MEDIUM_LOW)
	return TRUE

/datum/job/russian/ruff_radioman
	title = "Russian Federal Forces Artillery Liaison"
	en_meaning = "Radio Operator"
	rank_abbreviation = "Pfc."

	spawn_location = "JoinLateRURadop"

	is_rusretreat = TRUE
	is_radioman = TRUE
	uses_squads = TRUE
	is_modernday = TRUE
	is_ww2 = FALSE

	min_positions = 1
	max_positions = 5

/datum/job/russian/ruff_radioman/equip(var/mob/living/human/H)
	if (!H)	return FALSE
//shoes
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)

//clothes
	if (prob(60))
		H.equip_to_slot_or_del(new /obj/item/clothing/under/milrus_vsr93(H), slot_w_uniform)
		if (prob(65))
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/rus_winter_vsr93(H), slot_wear_suit)
	else
		H.equip_to_slot_or_del(new /obj/item/clothing/under/afghanka(H), slot_w_uniform)
		if (prob(65))
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/afghanka(H), slot_wear_suit)

	var/obj/item/clothing/under/uniform = H.w_uniform
	var/obj/item/clothing/accessory/armor/coldwar/platecarriergreen/armour = new /obj/item/clothing/accessory/armor/coldwar/platecarriergreen(null)
	uniform.attackby(armour, H)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/thick/combat(H), slot_gloves)

//head
	var/randhead3 = rand(1,3)
	switch(randhead3)
		if (1)
			if (prob(70))
				H.equip_to_slot_or_del(new /obj/item/clothing/head/ruscap_fed(H), slot_head)
			else
				H.equip_to_slot_or_del(new /obj/item/clothing/head/ww2/soviet_tanker(H), slot_head)
		if (2)
			if (prob(30))
				H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/modern/ssh_68(H), slot_head)
			else
				H.equip_to_slot_or_del(new /obj/item/clothing/head/ruscap_fed(H), slot_head)
		if (3)
			if (prob(40))
				H.equip_to_slot_or_del(new /obj/item/clothing/head/ruscap_fed(H), slot_head)
			else
				H.equip_to_slot_or_del(new /obj/item/clothing/head/olivebandana(H), slot_head)
//back
	var/randarmwrus = rand(1,2)
	switch(randarmwrus)
		if (1)
			H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/submachinegun/ak74(H), slot_shoulder)
			H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/smallpouches/green/sov_74_alt(H), slot_belt)
		if (2)
			H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/submachinegun/ak74(H), slot_shoulder)
			H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/smallpouches/green/sov_74(H), slot_belt)

	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/russia(H), slot_r_store)
	H.equip_to_slot_or_del(new /obj/item/weapon/radio/faction2(H), slot_back)




	H.f_style = pick("Selleck Mustache","Shaved")
	H.h_style = pick("Crewcut","Undercut","Short Hair","Cut Hair","Skinhead","Average Joe","Fade","Combover")

	var/new_hair = pick("Red","Orange","Light Blond","Blond","Dirty Blond","Light Brown")
	var/hex_hair = hair_colors[new_hair]
	H.r_hair = hex2num(copytext(hex_hair, 2, 4))
	H.g_hair = hex2num(copytext(hex_hair, 4, 6))
	H.b_hair = hex2num(copytext(hex_hair, 6, 8))
	H.r_facial = hex2num(copytext(hex_hair, 2, 4))
	H.g_facial = hex2num(copytext(hex_hair, 4, 6))
	H.b_facial = hex2num(copytext(hex_hair, 6, 8))

	H.civilization = "Russian"
	give_random_name(H)
	H.add_note("Role", "You are a <b>[title]</b>, you were conscripted right after your 18th birthday, but unlike your other comrades, they gave you a radio with your rifle and some additional evening classes during bootcamp! What a joy! Follow orders given by your superiors and defeat the enemy!")
	H.setStat("strength", STAT_NORMAL)
	H.setStat("crafting", STAT_MEDIUM_HIGH)
	H.setStat("rifle", STAT_NORMAL)
	H.setStat("dexterity", STAT_NORMAL)
	H.setStat("swords", STAT_NORMAL)
	H.setStat("pistol", STAT_NORMAL)
	H.setStat("bows", STAT_LOW)
	H.setStat("medical", STAT_LOW)
	H.setStat("machinegun", STAT_NORMAL)
	return TRUE

/datum/job/russian/ruff_soldier
	title = "Russian Federal Forces Private"
	rank_abbreviation = "Pvt."

	spawn_location = "JoinLateRU"

	is_rusretreat = TRUE
	is_modernday = TRUE
	is_ww2 = FALSE

	uses_squads = TRUE

	min_positions = 10
	max_positions = 80

/datum/job/russian/ruff_soldier/equip(var/mob/living/human/H)
	if (!H)	return FALSE
//shoes
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)

//clothes
	if (prob(60))
		H.equip_to_slot_or_del(new /obj/item/clothing/under/milrus_vsr93(H), slot_w_uniform)
		if (prob(65))
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/rus_winter_vsr93(H), slot_wear_suit)
	else
		H.equip_to_slot_or_del(new /obj/item/clothing/under/afghanka(H), slot_w_uniform)
		if (prob(65))
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/afghanka(H), slot_wear_suit)

	H.equip_to_slot_or_del(new /obj/item/weapon/radio/walkietalkie/faction2(H), slot_wear_id)
	var/obj/item/clothing/under/uniform = H.w_uniform
	var/obj/item/clothing/accessory/armor/coldwar/platecarriergreen/armour = new /obj/item/clothing/accessory/armor/coldwar/platecarriergreen(null)
	uniform.attackby(armour, H)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/thick/combat(H), slot_gloves)

//head
	var/randhead3 = rand(1,3)
	switch(randhead3)
		if (1)
			if (prob(70))
				H.equip_to_slot_or_del(new /obj/item/clothing/head/ruscap_fed(H), slot_head)
			else
				H.equip_to_slot_or_del(new /obj/item/clothing/head/ww2/soviet_tanker(H), slot_head)
		if (2)
			if (prob(70))
				H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/modern/ssh_68(H), slot_head)
			else
				H.equip_to_slot_or_del(new /obj/item/clothing/head/ruscap_fed(H), slot_head)
		if (3)
			if (prob(60))
				H.equip_to_slot_or_del(new /obj/item/clothing/head/ruscap_fed(H), slot_head)
			else
				H.equip_to_slot_or_del(new /obj/item/clothing/head/olivebandana(H), slot_head)
//back
	var/randarmwrus = rand(1,2)
	switch(randarmwrus)
		if (1)
			if (prob(80))
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/submachinegun/ak74(H), slot_shoulder)
				H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/smallpouches/green/sov_74_alt(H), slot_belt)
			else
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/pkm(H), slot_l_hand)
				H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/largepouches/pkm(H), slot_belt)
		if (2)
			if (prob(80))
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/submachinegun/ak74(H), slot_shoulder)
				H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/smallpouches/green/sov_74(H), slot_belt)
			else
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/semiautomatic/svd(H), slot_shoulder)
				H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/smallpouches/green/sov_svd(H), slot_belt)


	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/russia(H), slot_r_store)

	H.f_style = pick("Selleck Mustache","Shaved")
	H.h_style = pick("Crewcut","Undercut","Short Hair","Cut Hair","Skinhead","Average Joe","Fade","Combover")

	var/new_hair = pick("Red","Orange","Light Blond","Blond","Dirty Blond","Light Brown")
	var/hex_hair = hair_colors[new_hair]
	H.r_hair = hex2num(copytext(hex_hair, 2, 4))
	H.g_hair = hex2num(copytext(hex_hair, 4, 6))
	H.b_hair = hex2num(copytext(hex_hair, 6, 8))
	H.r_facial = hex2num(copytext(hex_hair, 2, 4))
	H.g_facial = hex2num(copytext(hex_hair, 4, 6))
	H.b_facial = hex2num(copytext(hex_hair, 6, 8))

	H.civilization = "Russian"
	give_random_name(H)
	H.add_note("Role", "You are a <b>[title]</b>, you were conscripted right after your 18th birthday; What a joy! Follow orders given by your superiors and defeat the enemy!")
	H.setStat("strength", STAT_NORMAL)
	H.setStat("crafting", STAT_MEDIUM_LOW)
	H.setStat("rifle", STAT_MEDIUM_LOW)
	H.setStat("dexterity", STAT_NORMAL)
	H.setStat("swords", STAT_NORMAL)
	H.setStat("pistol", STAT_NORMAL)
	H.setStat("bows", STAT_LOW)
	H.setStat("medical", STAT_LOW)
	H.setStat("machinegun", STAT_NORMAL)
	return TRUE

/datum/job/russian/ruff_spetznaz
	title = "Spetznaz GRU Operative"
	rank_abbreviation = "Spz. Op."

	spawn_location = "JoinLateRUsptz"
	whitelisted = TRUE
	is_rusretreat = TRUE
	is_modernday = TRUE
	is_ww2 = FALSE

	uses_squads = TRUE

	min_positions = 1
	max_positions = 8

/datum/job/russian/ruff_spetznaz/equip(var/mob/living/human/H)
	if (!H)	return FALSE
//shoes
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/iogboots/black(H), slot_shoes)

//clothes
	H.equip_to_slot_or_del(new /obj/item/clothing/under/gorka(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/weapon/radio/walkietalkie/faction2(H), slot_wear_id)
	var/obj/item/clothing/under/uniform = H.w_uniform
	var/obj/item/clothing/accessory/armor/coldwar/platecarriergreen/armour = new /obj/item/clothing/accessory/armor/coldwar/platecarriergreen(null)
	uniform.attackby(armour, H)
	var/obj/item/clothing/accessory/holster/hip/holsterh = new /obj/item/clothing/accessory/holster/hip(null)
	uniform.attackby(holsterh, H)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/thick/swat(H), slot_gloves)

//head
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/thermal(H), slot_eyes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/modern/sovietfacehelmet/welding(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava(H), slot_wear_mask)
//back
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/special/ak74mtactical(H), slot_shoulder)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/smallpouches/green/sov_spz(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/rucksack(H), slot_back)

	H.equip_to_slot_or_del(new /obj/item/clothing/suit/b3(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/revolver/nagant_revolver(H), slot_l_hand)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/russia(H), slot_wear_mask)
	H.equip_to_slot_or_del(new /obj/item/weapon/attachment/scope/adjustable/binoculars(H), slot_l_store)

	H.f_style = pick("Goatee","Selleck Mustache","Shaved")
	H.h_style = pick("Bald","Crewcut","Undercut","Short Hair","Cut Hair","Skinhead","Average Joe","Fade","Combover")

	var/new_hair = pick("Red","Orange","Light Blond","Blond","Dirty Blond","Light Brown")
	var/hex_hair = hair_colors[new_hair]
	H.r_hair = hex2num(copytext(hex_hair, 2, 4))
	H.g_hair = hex2num(copytext(hex_hair, 4, 6))
	H.b_hair = hex2num(copytext(hex_hair, 6, 8))
	H.r_facial = hex2num(copytext(hex_hair, 2, 4))
	H.g_facial = hex2num(copytext(hex_hair, 4, 6))
	H.b_facial = hex2num(copytext(hex_hair, 6, 8))

	H.civilization = "Soviet Army"
	give_random_name(H)
	H.add_note("Role", "You are a <b>[title]</b>, part of the Spetznaz GRU. You are the best of the best; put an end to this conflict!")
	H.setStat("strength", STAT_HIGH)
	H.setStat("crafting", STAT_NORMAL)
	H.setStat("rifle", STAT_HIGH)
	H.setStat("dexterity", STAT_HIGH)
	H.setStat("swords", STAT_NORMAL)
	H.setStat("pistol", STAT_HIGH)
	H.setStat("bows", STAT_MEDIUM_LOW)
	H.setStat("medical", STAT_MEDIUM_LOW)
	H.setStat("machinegun", STAT_MEDIUM_HIGH)
	return TRUE