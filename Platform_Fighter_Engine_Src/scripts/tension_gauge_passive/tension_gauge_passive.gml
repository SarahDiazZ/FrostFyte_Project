///The passive script for adding a tension gauge
function tension_gauge_passive() {
	//Airdashing
	airdash_passive();

	var _tension_gauge_max = 500;

	//Make sure the variable is initialized
	if (!variable_struct_exists(custom_passive_struct, "tension_gauge"))
		{
		custom_passive_struct.tension_gauge = 0;
		}

	//Decrease when hit
	if (state == PLAYER_STATE.hitlag && state_time == 1)	
		{
		custom_passive_struct.tension_gauge -= 5;
		}
	//Decrease when grabbing the ledge
	else if (state == PLAYER_STATE.ledge_snap && state_time == 0)	
		{
		custom_passive_struct.tension_gauge -= 25;
		}
	//Decrease when dodging
	else if ((state == PLAYER_STATE.rolling || state == PLAYER_STATE.airdodging || state == PLAYER_STATE.spot_dodging) && state_time = 0)
		{
		custom_passive_struct.tension_gauge -= 10;
		}
	//Increase on hit
	else if (state == PLAYER_STATE.attacking && attack_connected() && self_hitlag_frame == 1)
		{
		custom_passive_struct.tension_gauge += 20;
		}
	//Increase when moving toward an opponent
	else
		{
		var _nearest = find_nearest_player(x, y);
		if (_nearest != noone && sign(hsp) == sign(_nearest.x - x))
			{
			custom_passive_struct.tension_gauge += 1;
			}
		}
	//Clamp
	custom_passive_struct.tension_gauge = clamp(custom_passive_struct.tension_gauge, 0, _tension_gauge_max);
		
	//Canceling attacks
	if (state == PLAYER_STATE.attacking && state_time > 0 && custom_passive_struct.tension_gauge >= _tension_gauge_max div 2)
		{
		if (input_pressed(INPUT.taunt))
			{
			attack_stop();
			
			//Freeze
			self_hitlag_frame = 5;
			
			//Visual effects
			vfx_create(spr_hit_counter, 1, 0, 36, x, y, 2, 0, "VFX_Layer_Below");
			
			//Use up gauge
			custom_passive_struct.tension_gauge -= _tension_gauge_max div 2;
			}
		}
		
	if (is_knocked_out())
		{
		custom_passive_struct.tension_gauge = 0;
		}
	return;
}
/* Copyright 2023 Springroll Games / Yosi */