/obj/item/clothing/suit/storage/labcoat
	name = "labcoat"
	desc = "A suit that protects against minor chemical spills."
	icon_state = "labcoat_open"
	item_state = "labcoat_open"
	blood_overlay_type = "coat"
	flags_armor_protection = CHEST|ARMS
	pockets = /obj/item/storage/internal/modular/medical
	permeability_coefficient = 0.6
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 50, FIRE = 0, ACID = 0)
	allowed = list(
		/obj/item/stack/medical,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/syringe,
		/obj/item/healthanalyzer,
		/obj/item/flashlight,
		/obj/item/radio,
		/obj/item/tank/emergency_oxygen,
	)
	///If the coat is buttoned or not
	var/open = FALSE

/obj/item/clothing/suit/storage/labcoat/Initialize()
	. = ..()
	toggle_open()

/obj/item/clothing/suit/storage/labcoat/verb/toggle()
	set name = "Toggle Labcoat Buttons"
	set category = "Object"
	set src in usr

	if(!isliving(usr))
		return
	if(usr.stat)
		return
	if(usr.restrained())
		return

	toggle_open()

	if(open)
		to_chat(usr, "You unbutton the labcoat.")
	else
		to_chat(usr, "You button up the labcoat.")

///Actually toggles the coat open or closed
/obj/item/clothing/suit/storage/labcoat/proc/toggle_open()
	open = !open

	if(open)
		icon_state = "[initial(icon_state)]_open"
	else
		icon_state = initial(icon_state)

	update_clothing_icon()

/obj/item/clothing/suit/storage/labcoat/cmo
	name = "chief medical officer's labcoat"
	desc = "Bluer than the standard model."
	icon_state = "labcoat_cmo"
	item_state = "labcoat_cmo"

/obj/item/clothing/suit/storage/labcoat/mad
	name = "The Mad's labcoat"
	desc = "It makes you look capable of konking someone on the noggin and shooting them into space."
	icon_state = "labgreen"
	item_state = "labgreen"

/obj/item/clothing/suit/storage/labcoat/genetics
	name = "Geneticist labcoat"
	desc = "A suit that protects against minor chemical spills. Has a blue stripe on the shoulder."
	icon_state = "labcoat_gen"
	item_state = "labcoat_gen_open"

/obj/item/clothing/suit/storage/labcoat/chemist
	name = "Chemist labcoat"
	desc = "A suit that protects against minor chemical spills. Has an orange stripe on the shoulder."
	icon_state = "labcoat_chem"
	item_state = "labcoat_chem"

/obj/item/clothing/suit/storage/labcoat/virologist
	name = "Virologist labcoat"
	desc = "A suit that protects against minor chemical spills. Offers slightly more protection against biohazards than the standard model. Has a green stripe on the shoulder."
	icon_state = "labcoat_viro"
	item_state = "labcoat_viro"

/obj/item/clothing/suit/storage/labcoat/science
	name = "Scientist labcoat"
	desc = "A suit that protects against minor chemical spills. Has a purple stripe on the shoulder."
	icon_state = "labcoat_sci"
	item_state = "labcoat_sci"

/obj/item/clothing/suit/storage/labcoat/researcher
	name = "Researcher's labcoat"
	desc = "A high quality labcoat, seemingly worn by scholars and researchers alike. It has a distinct rough feel to it, and goads you towards adventure."
	icon_state = "labcoat_researcher"
	item_state = "labcoat_researcher"
