///@category Player Standard States
/*
This script contains the default Lost state characters are given.

The Lost state is for players who are out of the game after losing all of their stocks.
*/
function standard_lost() {
	//Contains the standard actions for the lost state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_reset();
			anim_sprite = -1;
			
			//Invulnerability
			invulnerability_set(INV.invincible, 1);
			
			speed_set(0, 0, false, false);
			x = room_width div 2;
			y = room_height div 2;
			
			//Add yourself to the win screen order
			player_win_order_add(false);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			hurtbox_inv_set(hurtbox, INV.invincible, -1, false);
			
			speed_set(0, 0, false, false);
			x = room_width div 2;
			y = room_height div 2;
			
			//Share Stock
			if (share_stock_enable && setting().match_team_mode)
				{
				//Check for the the attack + special input
				if (input_pressed(INPUT.attack) && input_pressed(INPUT.special))
					{
					//Find the player with the highest number of stocks left (and the highest player number)
					//This ensures the same player is picked even if the instance order is messed up from rollback
					var _most_stocks = -1;
					var _number = -1;
					var _player = noone;
					with(obj_player)
						{
						if (player_team == other.player_team)
							{
							if (stock > _most_stocks)
								{
								_most_stocks = stock;
								_number = player_number;
								_player = id;
								}
							else if (stock == _most_stocks && player_number > _number)
								{
								_most_stocks = stock;
								_number = player_number;
								_player = id;
								}
							}
						}
						
					//Make sure the player has at least 1 stock to spare
					if (_most_stocks >= 2 && _player != noone)
						{
						_player.stock -= 1;
						stock = 1;
						
						//Respawn the player
						respawn();
						
						//Remove the player from the win screen order
						player_win_order_remove();
						run = false;
						}
					}
				}
	
			//No movement
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */