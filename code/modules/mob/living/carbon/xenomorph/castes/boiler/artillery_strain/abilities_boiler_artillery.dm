// ALL WIP XANTODO

// ***************************************
// *********** Corrosive shot
// ***************************************
/datum/action/ability/activable/xeno/corrosive_shot
	action_icon_state = "shift_spit_xeno_acid"
	ability_cost = 10

/datum/action/ability/activable/xeno/corrosive_shot/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/xeno_owner = owner

	if(!do_after(xeno_owner, 0.5 SECONDS, NONE, target, BUSY_ICON_DANGER))
		return fail_activate()

	//Shoot at the thing
	playsound(xeno_owner.loc, 'sound/effects/blobattack.ogg', 50, 1)

	var/datum/ammo/xeno/corrosive/corrosive_spit = GLOB.ammo_list[/datum/ammo/xeno/corrosive]

	var/obj/projectile/newspit = new /obj/projectile(get_turf(xeno_owner))
	newspit.generate_bullet(corrosive_spit, corrosive_spit.damage * SPIT_UPGRADE_BONUS(xeno_owner))
	newspit.def_zone = xeno_owner.get_limbzone_target()

	newspit.fire_at(target, xeno_owner, xeno_owner, newspit.ammo.max_range)

	succeed_activate()
	add_cooldown()

	//GLOB.round_statistics.spitter_scatter_spits++ //Statistics
	//SSblackbox.record_feedback("tally", "round_statistics", 1, "spitter_scatter_spits")

/datum/action/ability/activable/xeno/corrosive_shot/on_cooldown_finish()
	to_chat(owner, span_xenodanger("Our auxiliary sacks fill to bursting; we can use scatter spit again."))
	owner.playsound_local(owner, 'sound/voice/alien_drool1.ogg', 25, 0, 1)
	return ..()

/datum/ammo/xeno/corrosive
	icon_state = "xeno_acidshot"
	damage_type = BURN
	damage = 20
	ammo_behavior_flags = AMMO_XENO|AMMO_TARGET_TURF|AMMO_SKIPS_ALIENS
	max_range = 8

/datum/ammo/xeno/corrosive/on_hit_mob(mob/hit_mob, obj/projectile/proj)
	if(!isliving(hit_mob))
		return
	var/mob/living/victim = hit_mob
	victim.apply_status_effect(STATUS_EFFECT_SHATTER, 5 SECONDS)

// ***************************************
// *********** Glue shot
// ***************************************
/datum/action/ability/activable/xeno/glue_shot
	action_icon_state = "sticky resin"
	ability_cost = 10
	target_flags = ABILITY_TURF_TARGET

/datum/action/ability/activable/xeno/glue_shot/use_ability(atom/A)
	//Sends out a wave of goop which slows down any enemy that walks in it
	if(!do_after(xeno_owner, 0.5 SECONDS, NONE, target, BUSY_ICON_DANGER))
		return fail_activate()

	//Shoot at the thing
	playsound(xeno_owner.loc, 'sound/effects/blobattack.ogg', 50, 1)

	var/datum/ammo/xeno/glue/glue_spit = GLOB.ammo_list[/datum/ammo/xeno/glue]

	var/obj/projectile/newglue = new /obj/projectile(get_turf(xeno_owner))
	newglue.generate_bullet(glue_spit, glue_spit.damage * SPIT_UPGRADE_BONUS(xeno_owner))
	newglue.def_zone = xeno_owner.get_limbzone_target()

	newglue.fire_at(target, xeno_owner, xeno_owner, newglue.ammo.max_range)

	succeed_activate()
	add_cooldown()

	//GLOB.round_statistics.spitter_scatter_spits++ //Statistics
	//SSblackbox.record_feedback("tally", "round_statistics", 1, "spitter_scatter_spits")

/datum/action/ability/activable/xeno/glue_shot/on_cooldown_finish()
	to_chat(owner, span_xenodanger("Our auxiliary sacks fill to bursting; we can use scatter spit again."))
	owner.playsound_local(owner, 'sound/voice/alien_drool1.ogg', 25, 0, 1)
	return ..()

/datum/ammo/xeno/glue

// ***************************************
// *********** Acid Bombard
// ***************************************
/datum/action/ability/activable/xeno/acid_bombard
	action_icon_state = "Hemodile"
	ability_cost = 10
	target_flags = ABILITY_TURF_TARGET
	///How much damage the mobs take when they get splashed by this
	var/bombard_damage = 20

/datum/action/ability/activable/xeno/acid_bombard/use_ability(atom/target)
	//Prepares a visual indicator, after which a projecile lands on the turf and splashes anyone present
	new /obj/effect/temp_visual/bombard_indicator(target)
	addtimer(CALLBACK(src, PROC_REF(bombard_landing), target), 3 SECONDS)

/datum/action/ability/activable/xeno/acid_bombard/proc/bombard_landing(turf/target)
	for(var/mob/victims AS in target)
		if(!ishuman(victims))
			continue
		var/mob/living/carbon/human/victim = victims
		victim.emote("gored")
		victim.apply_damage(damage = bombard_damage, damagetype = BURN)

/obj/effect/temp_visual/bombard_indicator
	icon = 'icons/mob/actions.dmi'
	icon_state = "sniper_zoom"
	duration = 3 SECONDS
