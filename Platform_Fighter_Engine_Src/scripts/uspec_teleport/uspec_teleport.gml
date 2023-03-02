function uspec_teleport() {
	//Up Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Main Phases
	if (run)
		{
		switch(_phase)
			{
			//Initialize
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_uspec_teleport;
				anim_speed = 0;
				anim_frame = 0;
			
				speed_set(0, 0, false, false);
				attack_frame = 12;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 9)
					anim_frame = 1;
				if (attack_frame == 6)
					anim_frame = 2;
				if (attack_frame == 3)
					anim_frame = 3;
				
				if (attack_frame == 0)
					{
					anim_frame = 4;
				
					//Invulnerability
					invulnerability_set(INV.invincible, 10);
				
					attack_frame = 10;
					attack_phase++;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 6)
					anim_frame = 5;
				
				if (attack_frame == 0)
					{
					anim_frame = 6;
				
					//Teleport
					var _teleport_dir = stick_tilted(Lstick) ? stick_get_direction(Lstick) : 90;
					var _teleport_length = 250;
					var _move_x = lengthdir_x(_teleport_length, _teleport_dir);
					var _move_y = lengthdir_y(_teleport_length, _teleport_dir);
				
					move_x(_move_x);
				
					//Check ledge grab after every move vertically
					repeat(abs(_move_y))
						{
						move_y(false, sign(_move_y));
						
						//Snap to ledges
						if (check_ledge_grab()) then return;
						}
						
					//Reset the speed
					speed_set(0, 0, false, false);

					//Aerial vs grounded ending
					if (on_ground())
						{
						attack_frame = 15;
						attack_phase = 3;
						}
					else
						{
						landing_lag = 15;
						attack_frame = 15;
						attack_phase = 2;
						
						//Snap to ledges if you moved completely horizontally
						if (_move_y == 0)
							{
							if (check_ledge_grab()) then return;
							}
						}
					}
				break;
				}
			//Endlag aerial
			case 2:
				{
				//Snap to ledges
				if (check_ledge_grab()) then return;
						
				//Animation
				if (attack_frame == 12)
					anim_frame = 7;
				if (attack_frame == 9)
					anim_frame = 8;
				if (attack_frame == 6)
					anim_frame = 9;
				if (attack_frame == 3)
					anim_frame = 10;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			//Endlag grounded
			case 3:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 7;
				if (attack_frame == 9)
					anim_frame = 8;
				if (attack_frame == 6)
					anim_frame = 9;
				if (attack_frame == 3)
					anim_frame = 10;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */