///@category Player Actions
///@param {id} hitbox					The hitbox that is being parried
///@param {bool} stun_attacker			Whether to stun the attacker or not
///@param {id} target					The player who is parrying
/*
Triggers a "Press" parry.
This type of parry puts the opponent in parry stun after their attack ends, and gives the user invulnerability.
*/
function parry_press_trigger() {
	var _hit = argument[0],
		_atk = argument[1],
		_tar = argument[2];
	
	if (_hit.can_be_parried)
		{
		if (_atk)
			{
			with(_hit.owner)
				{
				has_been_parried = true;
				self_hitlag_frame = parry_press_hitlag;
				}
			}
		}

	with(_tar)
		{
		state_phase = PHASE.parry_press;
		state_frame = parry_press_trigger_time;
		self_hitlag_frame = parry_press_hitlag;
		}
	
	hit_sfx_play(snd_parry);
}
/* Copyright 2023 Springroll Games / Yosi */