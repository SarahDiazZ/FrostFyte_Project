///@category Player Actions
/*
The passive script assigned to players during respawn taunts that grants the following effects:
	- invincibility
	- the ability to cancel the taunt by moving the left stick
	- automatically ending the taunt if the respawn timer runs up
*/
function respawn_taunt_passive() {
	var run = true;
	var _canceled = false;
	assert(respawn_platform_taunt_enable, "[respawn_taunt_passive] This script should not be assigned if respawn_platform_taunt_enable is false");
	
	//Invulnerability
	hurtbox_inv_set(hurtbox, INV.invincible, 1, false);
	
	//Respawn time limit
	if (run && state_frame == 0)
		{
		//Aerial State
		attack_stop(PLAYER_STATE.aerial);
		
		run = false;
		_canceled = true;
		}
	
	//Manual Cancel
	if (run && stick_tilted(Lstick))
		{
		attack_stop(PLAYER_STATE.aerial);
	
		if (respawn_platform_change_facing)
			{
			if (sign(stick_get_value(Lstick, DIR.horizontal)) != 0)
				{
				facing = sign(stick_get_value(Lstick, DIR.horizontal));
				}
			}
	
		run = false;
		_canceled = true;
		}
		
	//Just in case it gets canceled another way
	if (run && state != PLAYER_STATE.attacking)
		{
		_canceled = true;
		}
	
	//Cancel effects
	if (_canceled)
		{
		hurtbox_inv_set(hurtbox, INV.invincible, respawn_inv_time, false);
		callback_remove(callback_passive, respawn_taunt_passive);
		callback_remove(callback_draw_end, respawn_taunt_draw_end);
		}
}
/* Copyright 2023 Springroll Games / Yosi */