/*!
 * Component that handles the welding fuel storage and interactions
 */

/datum/component/welding_fuel_storage
	///Maximum amount of fuel that can be stored in parent (in units)
	var/fuel_max_capacity = 100
	///Current amount of fuel stored in parent (in units)
	var/fuel_amount = 0 //We fill up on /Init by default

/datum/component/welding_fuel_storage/Initialize(maximum_capacity, start_empty = FALSE)
	. = ..()
	if(maximum_capacity) //Please override
		fuel_max_capacity = maximum_capacity
	if(!start_empty) //Set to true if you want it to be empty on spawn
		fuel_amount = fuel_max_capacity

/datum/component/welding_fuel_storage/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, PROC_REF(request_fuel))
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK_ALTERNATE, PROC_REF(inject_fuel))
	RegisterSignal(parent, COMPONENT_ON_REQUEST_FUEL, PROC_REF(on_fuel_response))

/datum/component/welding_fuel_storage/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(
		COMSIG_ATOM_EXAMINE,
		COMSIG_ITEM_AFTERATTACK,
		COMSIG_ITEM_AFTERATTACK_ALTERNATE,
		COMPONENT_ON_REQUEST_FUEL,
	))

///When you examine parent, it tells you how much current fuel it has and its maximum capacity
/datum/component/welding_fuel_storage/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_info("[parent] contains [fuel_amount]/[fuel_max_capacity] units of fuel")

///Request fuel when you left click anything with parent in hand
/datum/component/welding_fuel_storage/proc/request_fuel(datum/source, atom/target, mob/user, has_proximity, click_parameters)
	SIGNAL_HANDLER
	if(!has_proximity)
		return

	var/maxium_fuel_to_draw = fuel_max_capacity - fuel_amount //Check how much fuel we can hold
	if(!maxium_fuel_to_draw) //Our storage is full, we can't transfer any fuel
		user.balloon_alert(user, "[source] is full of fuel")
		return

	var/fuel_returned = SEND_SIGNAL(parent, COMPONENT_ON_REQUEST_FUEL) //Check how much fuel is in the thing we clicked on with parent
	if(!fuel_returned)
		user.balloon_alert(user, "No fuel in [target]")
		return

	if(fuel_returned >= maxium_fuel_to_draw) //If the object has more fuel than we can hold
		var/fuel_transferred = fuel_max_capacity - fuel_amount
		fuel_amount += fuel_transferred
		INVOKE_ASYNC(src, PROC_REF(remove_fuel), target, fuel_transferred)

	else //Else we just transfer whatever fuel is left
		var/fuel_transferred = fuel_returned
		fuel_amount += fuel_transferred
		INVOKE_ASYNC(src, PROC_REF(remove_fuel), target, fuel_transferred)

///Returns the amount of fuel in src
/datum/component/welding_fuel_storage/proc/on_fuel_response()
	return fuel_amount

///Removes fuel from source
/datum/component/welding_fuel_storage/proc/remove_fuel(datum/source, fuel_to_remove)
	fuel_amount -= fuel_to_remove
	if(fuel_amount < 0)
		CRASH("[source] ended up with a negative amount of fuel")

///Try to inject fuel when you right click anything with parent in hand
/datum/component/welding_fuel_storage/proc/inject_fuel(datum/source, atom/target, mob/user, has_proximity, click_parameters)
	SIGNAL_HANDLER








