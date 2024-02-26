/datum/storage/reagent_tank
	max_w_class = WEIGHT_CLASS_SMALL //Beaker size
	storage_slots = null
	max_storage_space = 5
	can_hold = list(/obj/item/reagent_containers, /obj/item/reagent_scanner)

/datum/storage/reagent_tank/open(mob/user)
	var/obj/item/reagent_tank = parent
	if(CHECK_BITFIELD(reagent_tank.flags_item, IS_DEPLOYED))
		return ..()

/datum/storage/reagent_tank/attempt_draw_object(mob/living/user)
	var/obj/item/reagent_tank = parent
	if(!CHECK_BITFIELD(reagent_tank.flags_item, IS_DEPLOYED))
		user.balloon_alert(user, "Not deployed")
		return FALSE
	return ..()

/datum/storage/reagent_tank/can_be_inserted(obj/item/item_to_insert, warning)
	var/obj/item/reagent_tank = parent
	if(!CHECK_BITFIELD(reagent_tank.flags_item, IS_DEPLOYED))
		usr.balloon_alert(usr, "Not deployed")
		return FALSE
	return ..()