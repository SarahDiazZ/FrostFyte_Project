///@category Items
/*
This is the script run by <obj_game> in <game_advance_frame> that handles spawning items randomly during the match.
Items are spawned at <obj_item_spawn_zone> locations, if setting().<match_items_enable> is true.
The settings <item_spawn_interval> and setting().<match_items_frequency> can be used to control how frequently items are spawned.
Please note: If there are already more items than the <item_limit>, no new items will be spawned.
*/
function item_spawn_script() {
	/*
	Item spawning conditions:
	- During the normal game state
	- Can't go over the <item_limit> number of items
	- Happens at most every <item_spawn_interval> frames, with the random chance of setting().<match_items_frequency>.
	*/
	if (!setting().match_items_enable) then return false;
	
	if (obj_game.state == GAME_STATE.normal)
		{
		if (obj_game.current_frame % item_spawn_interval == 0)
			{
			if (instance_number(obj_item_parent) < item_limit)
				{
				//Randomize based on the player's coordinates
				var _channel = 0;
				with(obj_player)
					{
					_channel += abs(x);
					}
				
				if (prng_number((_channel + 0) % prng_channels, 100) <= setting().match_items_frequency)
					{
					//Choose a random spawn zone
					assert(instance_number(obj_item_spawn_zone) > 0, "[item_spawn_script] There needs to be at least 1 instance of obj_item_spawn_zone in the room (", room_get_name(room), ")");
					var _num = prng_number((_channel + 1) % prng_channels, instance_number(obj_item_spawn_zone) - 1, 0);
					var _spawner = instance_find(obj_item_spawn_zone, _num);
					with(_spawner)
						{
						var _x = prng_number((_channel + 2) % prng_channels, (bbox_right - 1), bbox_left);
						var _y = prng_number((_channel + 3) % prng_channels, (bbox_bottom - 1), bbox_top);
						var _obj = prng_choose_weighted
							(
							4,
								[
								obj_item_explosive_box, 10,
								obj_item_flip_field, 10,
								obj_item_rock, 10,
								obj_item_final_smash_ball, 3,
								obj_item_ball, 10,
								obj_item_bat, 10,
								],
							);
						var _item = item_create(_x, _y, _obj, noone);
						
						//Move the item out of blocks upwards
						with(_item)
							{
							move_out_of_blocks(90);
							}
							
						//VFX
						vfx_create(spr_shine_attack, 1, 0, 8, _x, _y, 1, 41);
						vfx_create(spr_item_appear, 1, 0, 20, _x, _y, 2, 41);
						
						return _item;
						}
					}
				}
			}
		}
		
	return noone;
}
/* Copyright 2023 Springroll Games / Yosi */