///@category Player Standard States
/*
This script contains the default Ledge Tether state characters are given.

The Ledge Tether state is for players who are tethering towards the ledge to grab it.
Players in this state do not inherently have invulnerability.
*/
function standard_ledge_tether() {
	//Contains the standard actions for the ledge tether state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "LedgeT"]);
			
			//Tether phase
			state_phase = 0;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Verlet rope
			if (state_time == 1)
				{
				var _group = player_number;
				var _base = verlet_system_point_add(obj_game.verlet_system, ledge_id.x, ledge_id.y, true, _group);
				var _length = 25;
				var _total = point_distance(x, y, ledge_id.x, ledge_id.y);
				var _points = max(5, ceil(_total / _length));
				var _inc_x = (abs(ledge_id.x - x) * -sign(ledge_id.x - x)) / _points;
				var _inc_y = (abs(ledge_id.y - y) * -sign(ledge_id.y - y)) / _points;
				var _point = noone;
				var _prev = _base;
				for(var i = 1; i <= _points; i++)
					{
					_point = verlet_system_point_add(obj_game.verlet_system, ledge_id.x + (_inc_x * i), ledge_id.y + (_inc_y * i), false, _group, hsp / 2, vsp / 2);
					var _stick = verlet_system_stick_add(obj_game.verlet_system, _prev, _point);
					_stick.image_blend = palette_color_get(palette_data, 1);
					_prev = _point;
					}
				ledge_tether_point_id = _point;
				ledge_tether_point_id.mask_index = collision_box;
				}
			
			//Grab the ledge if you are close enough
			if (check_ledge_grab()) then return;
			
			//Face the correct direction
			var _dir = sign(ledge_id.x - x);
			if (_dir != 0) then facing = _dir;
			
			//Cancel tether if you move over the ledge
			if (y < ledge_id.y && _dir != ledge_id.image_xscale)
				{
				facing = ledge_id.image_xscale;
				state_set(PLAYER_STATE.aerial);
				run = false;
				}
			
			//Hang phase
			if (run)
				{
				if (state_phase == 0)
					{
					//Transition to snap
					if (state_time > ledge_tether_hang_time || input_pressed(INPUT.grab, 0) || distance_to_point(ledge_id.x, ledge_id.y) < ledge_grab_distance)
						{
						state_phase = 1;
						state_frame = ledge_tether_snap_time;
						verlet_system_group_destroy(obj_game.verlet_system, player_number);
						ledge_tether_point_id = noone;
						}
					//Jump cancel
					else if (double_jumps > 0 && input_pressed(INPUT.jump))
						{
						double_jumps -= 1;
						input_reset(INPUT.jump);
					
						//VFX
						vfx_create(spr_dust_air_jump, 1, 0, 7, x, y, 2, 0);
					
						//Speeds - does NOT use the double_jump() logic!
						speed_set(ledge_tether_jump_hsp * facing, ledge_tether_jump_vsp, false, false);
						
						state_set(PLAYER_STATE.aerial);
						run = false;
						}
					else
						{
						//Speed
						speed_set((ledge_tether_point_id.x - x), (ledge_tether_point_id.y - y), false, false);
						}
					}
				//Snap phase
				else
					{
					//Grab the ledge if you are close enough
					if (check_ledge_grab()) then return;
		
					//Go to a ledge snap when the timer is done
					if (state_frame == 0)
						{
						//Snap to the ledge
						x = ledge_id.x + (ledge_hang_relative_x * facing);
						y = ledge_id.y + (ledge_hang_relative_y);
	
						run = false;
						state_set(PLAYER_STATE.ledge_snap);
						state_frame = ledge_snap_time;
						//VFX
						vfx_create(spr_shine_ledge_grab, 1, 0, 10, ledge_id.x, ledge_id.y, 1, prng_number(0, 360));
						}
					else
						{
						//Move toward the ledge
						speed_set_towards_point_accel
							(
							ledge_id.x + (ledge_hang_relative_x * facing),
							ledge_id.y + (ledge_hang_relative_y),
							ledge_tether_snap_accel,
							ledge_tether_snap_speed,
							);
						}
					}
				}
				
			move_through_platforms();
			break;
			}
		case PLAYER_STATE_PHASE.stop:
			{
			verlet_system_group_destroy(obj_game.verlet_system, player_number);
			ledge_tether_point_id = noone;
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */