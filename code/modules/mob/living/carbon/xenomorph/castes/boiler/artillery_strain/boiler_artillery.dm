/mob/living/carbon/xenomorph/boiler/artillery_strain
	caste_base_type = /datum/xeno_caste/boiler/artillery_strain
	name = "Artillery"
	desc = "A huge, grotesque xenomorph covered in glowing, oozing acid slime."
	icon = 'icons/Xeno/castes/boiler.dmi'
	icon_state = "Boiler Walking"
	bubble_icon = "alienroyal"
	health = 200
	maxHealth = 200
	plasma_stored = 450
	pixel_x = -16
	old_x = -16
	mob_size = MOB_SIZE_BIG
	tier = XENO_TIER_THREE
	upgrade = XENO_UPGRADE_NORMAL
	gib_chance = 100
	drag_delay = 6 //pulling a big dead xeno is hard

/mob/living/carbon/xenomorph/boiler/artillery_strain/Initialize(mapload)
	. = ..()
	smoke = null
	ammo = null

	color = "#33CC33"
