///@category Player Actions
///@param {id} hitbox					The hitbox that is being parried
///@param {bool} apply_hitlag			Whether to freeze the attacker or not
///@param {id} target					The player who is parrying
/*
Triggers a "Shield" parry.
This type of parry gives the user brief invulnerability, but does not stun the opponent.
*/
function parry_shield_trigger() {
	var _hit = argument[0],
		_atk = argument[1],
		_tar = argument[2];
	
	if (_atk)
		{
		with(_hit.owner)
			{
			self_hitlag_frame = _tar.parry_ult_freeze_time;
			}
		}

	with(_tar)
		{
		self_hitlag_frame = parry_ult_self_freeze_time;
		invulnerability_set(INV.invincible, parry_ult_self_freeze_time);
		state_frame = 0;
		anim_set(parry_ult_sprite);
		//Parry VFX
		var _vfx = vfx_create(spr_hit_parry, 1, 0, 18, x, (bbox_bottom - 1), 1, 0, "VFX_Layer_Below");
		_vfx.vfx_xscale = prng_choose(0, -1, 1);
		_vfx.vfx_allow_fade = false;
		vfx_create_action_lines(parry_ult_self_freeze_time, x, y, prng_number(0, 10));
		}
		
	camera_shake(4);
	background_clear_activate(6, c_black, -1, 0.05);
	hit_sfx_play(snd_parry);
}
/* Copyright 2023 Springroll Games / Yosi */