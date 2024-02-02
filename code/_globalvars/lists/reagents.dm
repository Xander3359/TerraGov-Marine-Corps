/// List of containers the Chem Master machine can print
GLOBAL_LIST_INIT(reagent_containers, list(
	CAT_BOTTLES = typecacheof(list(
		/obj/item/reagent_containers/glass/bottle/custom
	)),
	CAT_AUTOINJECTORS = typecacheof(list(
		/obj/item/reagent_containers/hypospray/autoinjector/custom
	)),
	CAT_PILL_BOTTLES = typecacheof(list(
		/obj/item/storage/pill_bottle/custom
	)),
	CAT_PILLS = typecacheof(list(
		/obj/item/reagent_containers/pill/custom
	)),
))
