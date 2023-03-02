///@category Hitboxes
///@param {id} hurtbox		The hurtbox instance
/*
Returns true if the calling hitbox is able to hit the given hurtbox, checking the owner, hitbox groups, and teams.
Does not check invulnerability or hit restrictions.
*/
function hitbox_can_hit_hurtbox() {
	var _hurtbox = argument[0];
	
	//Ensure the hurtbox still exists (it could be destroyed if attack_stop was called)
	if (!instance_exists(_hurtbox)) then return false;
	
	//Hitboxes cannot hit their owners
	if (_hurtbox.owner == noone || _hurtbox.owner == owner) then return false;
	
	//Hitboxes cannot hit someone who has already been hit
	var _array = owner.hitbox_groups[@ hitbox_group];
	if (array_contains(_array, _hurtbox.owner)) then return false;
	
	//Hitboxes can only hit teammates when team attack is on
	if (setting().match_team_mode)
		{
		//Players on the -1 team can be hit by any other team
		if (setting().match_team_attack || _hurtbox.owner.player_team == -1)
			{
			//Players can always hit each other, regardless of team
			return true;
			}
		else
			{
			//Players on the same team cannot hit each other
			if (owner.player_team == _hurtbox.owner.player_team)
				{
				return false;
				}
			}
		}
	
	return true;
}
/* Copyright 2023 Springroll Games / Yosi */