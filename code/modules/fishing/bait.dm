/obj/item/bait_can
	name = "can o bait"
	desc = "there's a lot of them in there, getting them out takes a while though"
	icon = 'icons/obj/fishing.dmi'
	icon_state = "bait_can"
	w_class = WEIGHT_CLASS_SMALL
	/// Tracking until we can take out another bait item
	COOLDOWN_DECLARE(bait_removal_cooldown)
	/// What bait item it produces
	var/bait_type
	/// Time between bait retrievals
	var/cooldown_time = 10 SECONDS

/obj/item/bait_can/attack_self(mob/user, modifiers)
	. = ..()
	var/fresh_bait = retrieve_bait(user)
	if(fresh_bait)
		user.put_in_hands(fresh_bait)

/obj/item/bait_can/proc/retrieve_bait(mob/user)
	if(!COOLDOWN_CHECK(src, bait_removal_cooldown))
		user.balloon_alert(user, "wait a bit") //I can't think of generic ic reason.
		return
	COOLDOWN_START(src, bait_removal_cooldown, cooldown_time)
	return new bait_type(src)

/obj/item/bait_can/worm
	name = "can o' worm"
	desc = "this can got worms."
	bait_type = /obj/item/food/bait/worm

/obj/item/bait_can/worm/premium
	name = "can o' worm deluxe"
	desc = "this can got fancy worms."
	bait_type = /obj/item/food/bait/worm/premium

/obj/item/food/bait
	name = "this is bait"
	desc = "you got baited."
	icon = 'icons/obj/fishing.dmi'
	/// Quality trait of this bait
	var/bait_quality = TRAIT_BASIC_QUALITY_BAIT
	/// Icon state added to main fishing rod icon when this bait is equipped
	var/rod_overlay_icon_state

/obj/item/food/bait/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, bait_quality, INNATE_TRAIT)

/obj/item/food/bait/worm
	name = "worm"
	desc = "It's a wriggling worm from a can of fishing bait. You're not going to eat it are you ?"
	icon = 'icons/obj/fishing.dmi'
	icon_state = "worm"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 1)
	tastes = list("meat" = 1, "worms" = 1)
	foodtypes = GROSS | MEAT | BUGS
	w_class = WEIGHT_CLASS_TINY
	bait_quality = TRAIT_BASIC_QUALITY_BAIT
	rod_overlay_icon_state = "worm_overlay"

/obj/item/food/bait/worm/premium
	name = "extra slimy worm"
	desc = "This worm looks very sophisticated."
	bait_quality = TRAIT_GOOD_QUALITY_BAIT

/obj/item/food/bait/natural
	name = "natural bait"
	desc = "Fish can't seem to get enough of this!"
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "pill9"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	inhand_icon_state = "pen"
	food_reagents = list(/datum/reagent/drug/kronkaine = 1)
	tastes = list("hypocrisy" = 1)
	bait_quality = TRAIT_GREAT_QUALITY_BAIT

/obj/item/food/bait/doughball
	name = "doughball"
	desc = "Small piece of dough. Simple but effective fishing bait."
	icon = 'icons/obj/fishing.dmi'
	icon_state = "doughball"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 1)
	tastes = list("dough" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	bait_quality = TRAIT_BASIC_QUALITY_BAIT
	rod_overlay_icon_state = "dough_overlay"

/**
 * Bound to the tech fishing rod, from which cannot be removed,
 * Bait-related preferences and traits, both negative and positive,
 * should be ignored by this bait.
 * Otherwise it'd be hard/impossible to cath some fish with it,
 * making that rod a shoddy choice in the long run.
 */
/obj/item/food/bait/doughball/synthetic
	name = "synthetic doughball"
	icon_state = "doughball"
	preserved_food = TRUE

/obj/item/food/bait/doughball/synthetic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_OMNI_BAIT, INNATE_TRAIT)

