/mob/living/simple_animal/hostile/graga
	name = "грага"
	desc = ""
	icon = 'lambda/sanecman/icons/mob/critter.dmi'
	icon_state = "graga"
	speak_emote = list("gibbers")
	icon_living = "graga"
	deals_blunt = 1
	icon_dead = "graga2"
	health = 450
	maxHealth = 450
	melee_damage_lower = 145
	melee_damage_upper = 145
	move_to_delay = 15
	break_stuff_probability = 100
	speak_chance = 1
	robust_searching = 0
	speak = list("АГГГГГГГГГР!","ГРРРРРРРРРРРРР!")
	attacktext = "punches"
	destroy_surroundings = 2
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	search_objects = 0
	attack_sound = 'lambda/sanecman/sound/lifeweb/graga/graga_attack6.ogg'
	faction = "creature"
	speed = 25
	a_intent = "harm"
	wall_smash = 1
	status_flags = CANPUSH
	stat_attack = 1
	stance = HOSTILE_STANCE_ATTACK
	item_worth = 300

/mob/living/simple_animal/hostile/graga/New()
	if(prob(10))
		src.name = "[pick("Иван", "Слава", "Дима", "Александр", "Валера", "Леонид", "Стас")]"
	if(src.name == "Стас")
		src.color = "#A52A2A"
	..()

/mob/living/simple_animal/hostile/graga/Move()
	if(stat != 0)
		return
	var/selectedSound = pick('lambda/sanecman/sound/lifeweb/graga/graga_life1.ogg', 'lambda/sanecman/sound/lifeweb/graga/graga_life2.ogg', 'lambda/sanecman/sound/lifeweb/graga/graga_life3.ogg')
	var/stepSound = pick('lambda/sanecman/sound/lifeweb/graga/graga_step1.ogg', 'lambda/sanecman/sound/lifeweb/graga/graga_step2.ogg')
	playsound(src.loc, stepSound, 50, 0, -1)
	if(prob(5))
		visible_message("<b class='danger'><h3>[pick("АХХХХХХ", "УХХХХХ", "ХГХХХХ")]<h3></b>")
		playsound(src.loc, selectedSound, 50, 1, -1)
	for(var/mob/living/human/H in view(world.view, src))
		shake_camera(H, 1, 1)
	return ..()

/mob/living/simple_animal/hostile/graga/ListTargets()
	return view(12, src) - src

/mob/living/simple_animal/hostile/graga/movement_delay()
	var/tally = 25 //Incase I need to add stuff other than "speed" later
	return tally

/mob/living/simple_animal/hostile/graga/AttackingTarget()
	..()
	if(ishuman(target))
		var/mob/living/human/H = target
		var/edgeTurf = get_edge_target_turf(src, src.dir)
		H.throw_at(edgeTurf, 4,	 2)
		var/chosenOrgan = pick(H?.organs_by_name)
		H.apply_damage(500, BRUTE, chosenOrgan)
		return H

/mob/living/simple_animal/hostile/graga/attackby(var/obj/item/O as obj, var/mob/user as mob)  //Marker -Agouri
	if(istype(O, /obj/item/stack/medical))

		if(stat != DEAD)
			var/obj/item/stack/medical/MED = O
			if(health < maxHealth)
				if(MED.amount >= 1)
					adjustBruteLoss(-MED.heal_brute)
					MED.amount -= 1
					if(MED.amount <= 0)
						qdel(MED)
					for(var/mob/M in viewers(src, null))
						if ((M.client && !( M.blinded )))
							M.show_message("\blue [user] applies the [MED] on [src]")
		else
			user << "\blue this [src] is dead, medical items won't bring it back to life."
//	if(meat_type && (stat == DEAD))	//if the animal has a meat, and if it is dead.
//		if(istype(O, /obj/item/weapon/kitchenknife) || istype(O, /obj/item/weapon/butch) || istype(O, /obj/item/weapon/kitchen/utensil/knife))
//			new meat_type (get_turf(src))
//			new meat_type (get_turf(src))
//			new meat_type (get_turf(src))
//			new leather_type (get_turf(src))
//			new leather_type (get_turf(src))
//			//del(src)
//			gib(src)
	else
		if(O.force)
			var/damage = O.force
			if (O.damtype == HALLOSS)
				damage = 0
			adjustBruteLoss(damage)
			for(var/mob/M in viewers(src, null))
				if ((M.client && !( M.blinded )))
					M.show_message("<span class='hitbold'>[src]</span> <span class='hit'>has been attacked with the [O] by</span> <span class='hitbold'>[user]</span><span class='hit'>.</span> ")
					playsound(src, O.hitsound, 25, 0, -1)
		else
			to_chat(usr, "<span class='combatbold'>Его броня слишком прочная.</span>")
			for(var/mob/M in viewers(src, null))
				if ((M.client && !( M.blinded )))
					M.show_message("<span class='combatbold'>[user]</span> <span class='combat'>gently taps</span> <span class='combatbold'>[src]</span> <span class='combat'>with the [O].</span> ")