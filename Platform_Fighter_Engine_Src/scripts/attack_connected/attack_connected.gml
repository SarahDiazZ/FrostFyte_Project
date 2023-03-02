///@category Attacking
///@param {bool} [count_blocked]		If blocked hits should count
///@param {bool} [only_blocked]			If only blocked hits should count
/*
Checks if any hitbox of the calling player has registered a hit yet.
You can use the optional arguments to check for attacks being blocked.
	- attack_connected(true) : Checks if the attack has hit or been blocked
	- attack_connected(true, true) : Checks if the attack has been blocked
	
Warning: This will NOT work when called from a projectile!
You should directly check the projectile's "has_hit" and "has_been_blocked" variables instead.
*/
function attack_connected() {
	//Projectiles do not count
	//Hitting a shield or getting parried won't count unless count_blocked_hits is true
	var _count_blocked = argument_count > 0 ? argument[0] : false;
	var _only_blocked = argument_count > 1 ? argument[1] : false;

	if (_count_blocked)
		{
		if (_only_blocked) then return any_hitbox_has_been_blocked;
		else return any_hitbox_has_hit || any_hitbox_has_been_blocked;
		}
	else return any_hitbox_has_hit;
}
/* Copyright 2023 Springroll Games / Yosi */