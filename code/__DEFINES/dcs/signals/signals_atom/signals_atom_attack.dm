// Atom attack signals. Format:
// When the signal is called: (signal arguments)
// All signals send the source datum of the signal as the first argument

///from base of atom/attackby(): (/obj/item, /mob/living)
#define COMSIG_ATOM_ATTACKBY "atom_attackby"
///from base of atom/attackby_alternate(): (/obj/item, /mob/living)
#define COMSIG_ATOM_ATTACKBY_ALTERNATE "atom_attackby_alternate"
///Return this in response if you don't want afterattack to be called
	#define COMPONENT_NO_AFTERATTACK (1<<0)
///from base of atom/attack_hand(mob/living/user)
#define COMSIG_ATOM_ATTACK_HAND "atom_attack_hand"
///from base of /atom/attack_hand_alternate(mob/living/user)
#define COMSIG_ATOM_ATTACK_HAND_ALTERNATE "atom_attack_hand_alternate"
///from base of atom/attack_ghost(): (mob/dead/observer/ghost)
#define COMSIG_ATOM_ATTACK_GHOST "atom_attack_ghost"
///works on all attack_hands.
	#define COMPONENT_NO_ATTACK_HAND (1<<0)
///from base of atom/attack_powerloader: (mob/living/user, obj/item/powerloader_clamp/attached_clamp)
#define COMSIG_ATOM_ATTACK_POWERLOADER "atom_attack_powerloader"

///from [/item/afterattack()], sent by an atom which was just attacked by an item: (/obj/item/weapon, /mob/user, proximity_flag, click_parameters)
#define COMSIG_ATOM_AFTER_ATTACKEDBY "atom_after_attackby"
///from relay_attackers element: (atom/attacker, attack_flags)
#define COMSIG_ATOM_WAS_ATTACKED "atom_was_attacked"
