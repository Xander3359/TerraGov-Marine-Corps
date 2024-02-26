/*!
 * Contains obj/item/storage template
 */

//--------------------------------
// When creating a new storage, you may use /obj/item/storage as a template which automates create_storage() on .../Initialize
// However, this is no longer a hard requirement, since storage is a /datum now
// Just make sure to pass whatever arguments you need to create_storage() which is an /atom level proc
// (This means that any atom can have storage :D )
/obj/item/storage
	name = "storage"
	icon = 'icons/obj/items/storage/storage.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/items/containers_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/containers_right.dmi',
	)
	w_class = WEIGHT_CLASS_NORMAL
	///Flags for specifically storage items
	var/flags_storage = NONE
	///Determines what subtype of storage is on our item, see datums\storage\subtypes
	var/datum/storage/storage_type = /datum/storage

/obj/item/storage/Initialize(mapload, ...)
	. = ..()
	create_storage(storage_type, storage_type.can_hold, storage_type.cant_hold, storage_type.bypass_w_limit)

	PopulateContents()

///Use this to fill your storage with items. USE THIS INSTEAD OF NEW/INIT
/obj/item/storage/proc/PopulateContents()
	return

/obj/item/storage/update_icon_state()
	. = ..()
	if(!atom_storage.sprite_slots)
		icon_state = initial(icon_state)
		return

	var/total_weight = 0

	if(!atom_storage.storage_slots)
		for(var/obj/item/i in contents)
			total_weight += i.w_class
		total_weight = ROUND_UP(total_weight / atom_storage.max_storage_space * atom_storage.sprite_slots)
	else
		total_weight = ROUND_UP(length(contents) / atom_storage.storage_slots * atom_storage.sprite_slots)

	if(!total_weight)
		icon_state = initial(icon_state) + "_e"
		return
	if(atom_storage.sprite_slots > total_weight)
		icon_state = initial(icon_state) + "_" + num2text(total_weight)
	else
		icon_state = initial(icon_state)
