/**
 * This element registers to a shitload of signals which can signify "someone attacked me".
 * If anyone does it sends a single "someone attacked me" signal containing details about who done it.
 * This prevents other components and elements from having to register to the same list of a million signals, should be more maintainable in one place.
 */
/datum/element/relay_attackers

/datum/element/relay_attackers/Attach(datum/target)
	. = ..()
	// Boy this sure is a lot of ways to tell us that someone tried to attack us
	RegisterSignal(target, COMSIG_ATOM_AFTER_ATTACKEDBY, PROC_REF(after_attackby))
	RegisterSignals(target, list(COMSIG_ATOM_ATTACK_HAND, COMSIG_OBJ_ATTACK_ALIEN), PROC_REF(on_attack_generic))
	RegisterSignal(target, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_bullet_act))
	RegisterSignal(target, COMSIG_MOVABLE_IMPACT, PROC_REF(on_hitby))
	ADD_TRAIT(target, TRAIT_RELAYING_ATTACKER, REF(src))

/datum/element/relay_attackers/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, list(
		COMSIG_ATOM_AFTER_ATTACKEDBY,
		COMSIG_ATOM_ATTACK_HAND,
		COMSIG_OBJ_ATTACK_ALIEN,
		COMSIG_ATOM_BULLET_ACT,
		COMSIG_MOVABLE_IMPACT,
	))
	REMOVE_TRAIT(source, TRAIT_RELAYING_ATTACKER, REF(src))

/datum/element/relay_attackers/proc/after_attackby(atom/target, obj/item/weapon, mob/attacker, has_proximity, click_parameters)
	SIGNAL_HANDLER
	if(!has_proximity) // we don't care about someone clicking us with a piece of metal from across the room
		return
	if(weapon.force)
		relay_attacker(target, attacker)

///Relays attacker when something attacks with an open hand
/datum/element/relay_attackers/proc/on_attack_generic(atom/target, mob/living/attacker, list/modifiers)
	SIGNAL_HANDLER

	switch(attacker.a_intent) //Pass whichever attack_flag based on our intento
		if(INTENT_HELP)
			relay_attacker(target, attacker, ATTACKER_ATTACK_HELP)
		if(INTENT_GRAB)
			relay_attacker(target, attacker, ATTACKER_ATTACK_GRAB)
		if(INTENT_DISARM)
			relay_attacker(target, attacker, ATTACKER_ATTACK_DISARM)
		if(INTENT_HARM)
			relay_attacker(target, attacker, ATTACKER_ATTACK_HARM)

/// Even if another component blocked this hit, someone still shot at us
/datum/element/relay_attackers/proc/on_bullet_act(atom/target, list/bullet_args, obj/projectile/hit_projectile)
	SIGNAL_HANDLER
	if(!ismob(hit_projectile.firer))
		return
	relay_attacker(target, hit_projectile.firer)

/// Even if another component blocked this hit, someone still threw something
/datum/element/relay_attackers/proc/on_hitby(atom/target, atom/movable/hit_atom)
	SIGNAL_HANDLER
	if(!isitem(hit_atom))
		return
	var/obj/item/hit_item = hit_atom
	if(!hit_item.throwforce)
		return
	var/mob/thrown_by = hit_item.thrower
	if(!ismob(thrown_by))
		return
	relay_attacker(target, thrown_by)

/// Send out a signal identifying whoever just attacked us (usually a mob but sometimes a mech or turret)
/datum/element/relay_attackers/proc/relay_attacker(atom/victim, atom/attacker, attack_flags)
	SEND_SIGNAL(victim, COMSIG_ATOM_WAS_ATTACKED, attacker, attack_flags)
