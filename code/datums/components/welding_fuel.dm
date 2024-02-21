/*!
 * Component that handles the welding fuel storage and interactions
 */

/datum/component/welding_fuel_storage
	///Maximum amount of fuel that can be stored in parent (in units)
	var/fuel_max_capacity = 100
	///Current amount of fuel stored in parent (in units)
	var/fuel_amount = 100 //We start full by default

/datum/component/welding_fuel_storage/Initialize(maximum_capacity, start_empty = FALSE)
	. = ..()
	if(maximum_capacity)
		fuel_max_capacity = maximum_capacity
	if(!start_empty) //Set to true if you want it to be empty on spawn
		fuel_amount = fuel_max_capacity

/datum/component/welding_fuel_storage/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOB_EXAMINATE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, PROC_REF(request_fuel))
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK_ALTERNATE, PROC_REF(inject_fuel))

/datum/component/welding_fuel_storage/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_MOB_EXAMINATE, COMSIG_ITEM_AFTERATTACK, COMSIG_ITEM_AFTERATTACK_ALTERNATE))

///When you examine parent, it tells you how much current fuel it has and its maximum capacity
/datum/component/welding_fuel_storage/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_info("[parent] contains [fuel_amount]u of fuel out of [fuel_max_capacity]u maximum")

///Request fuel when you left click anything with parent in hand
/datum/component/welding_fuel_storage/proc/request_fuel(datum/source, atom/target, mob/user, has_proximity, click_parameters)
	SIGNAL_HANDLER


///Try to inject fuel when you right click anything with parent in hand
/datum/component/welding_fuel_storage/proc/inject_fuel(datum/source, atom/target, mob/user, has_proximity, click_parameters)
	SIGNAL_HANDLER








