/proc/reagent_paths_list_to_text(list/reagents, addendum)
	var/list/temp = list()
	for(var/datum/reagent/R as anything in reagents)
		temp |= initial(R.name)
	if(addendum)
		temp += addendum
	return jointext(temp, ", ")
