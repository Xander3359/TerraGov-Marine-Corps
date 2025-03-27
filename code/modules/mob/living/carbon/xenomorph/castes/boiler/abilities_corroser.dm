/*!
 * Contains the abilities for the Corroser, a strain of Boiler
 */

// Roots in place. Once rooted you can bombard an area until you run out of charge
/datum/action/ability/activable/xeno/corroser_bombard

/datum/action/ability/activable/xeno/corroser_bombard/on_selection()
	var/current_ammo = xeno_owner.bombardments
	if(current_ammo <= 0)
		to_chat(xeno_owner, span_notice("We have nothing prepared to fire."))
		xeno_owner.selected_ability = null
		xeno_owner.update_action_button_icons()
		return FALSE

	xeno_owner.visible_message(span_notice("\The [xeno_owner] begins digging their claws into the ground."), \
	span_notice("We begin digging ourselves into place."), null, 5)
	if(!do_after(xeno_owner, 1 SECONDS, FALSE, null, BUSY_ICON_HOSTILE))
		on_deselection()
		xeno_owner.selected_ability = null
		xeno_owner.update_action_button_icons()
		xeno_owner.reset_bombard_pointer()
		return FALSE

	xeno_owner.icon_state = "Corroser Rooted"
	xeno_owner.update_icon(UPDATE_ICON)
	flick("Corroser Rooting", xeno_owner) // Custom rooting animation
	xeno_owner.visible_message(span_notice("\The [xeno_owner] digs itself into the ground!"), \
		span_notice("We dig ourselves into place! If we move, we must wait again to fire."), null, 5)
	xeno_owner.set_bombard_pointer()
	RegisterSignal(owner, COMSIG_MOB_ATTACK_RANGED, PROC_REF(on_ranged_attack))

/datum/action/ability/activable/xeno/corroser_bombard/proc/on_ranged_attack()
	var/current_ammo = xeno_owner.bombardments

/datum/action/ability/activable/xeno/corroser_bombard/on_deselection()
	if(xeno_owner?.selected_ability == src)
		xeno_owner.reset_bombard_pointer()
		xeno_owner.icon_state = initial(xeno_owner.icon_state)
		xeno_owner.update_icon(UPDATE_ICON)
		to_chat(xeno_owner, span_notice("We relax our stance."))
	UnregisterSignal(owner, COMSIG_MOB_ATTACK_RANGED)
