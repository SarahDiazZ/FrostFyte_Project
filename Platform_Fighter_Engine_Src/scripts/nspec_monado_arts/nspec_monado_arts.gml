function nspec_monado_arts() {
	//Neutral Special
	/*
	- Hold down the button and select an art from the wheel
	- If no art is selected, the current art is canceled
	- There are 5 different arts:
		1. Jump: + Jump speed, - Aerial drift
		2. Speed: + Movement speed, - Jump speed
		3. Buster: + Damage, - Base knockback
		4. Shield: - Damage, - Base knockback, + Shield HP, + Weight
		5. Smash: + Base knockback, - Damage
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	if (on_ground())
		{
		friction_gravity(ground_friction);
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
		}
		
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dspec_shine;
				anim_frame = 0;
				anim_speed = 0;
			
				attack_frame = 6;
				
				reverse_b();
				
				//Callbacks
				callback_add(callback_passive, nspec_monado_arts_passive, CALLBACK_TYPE.permanent, id, false);
				callback_add(callback_draw_end, nspec_monado_arts_draw);
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					b_reverse();
					
					anim_frame = 2;
				
					attack_phase++;
					attack_frame = 6;
					}
				break;
				}
			//Choosing Arts
			case 1:
				{
				if (attack_frame == 0 && !input_held(INPUT.special))
					{
					var _s = custom_passive_struct;
					
					//Select an art
					var _selected = -1;
					var _previous = _s.art_selected;
					if (stick_tilted(Lstick))
						{
						var _num_of_arts = 5;
						var _angle_inc = (360 / _num_of_arts);
						_selected = modulo(stick_get_direction(Lstick) - (_angle_inc / 2), 360) div _angle_inc;
						_selected = clamp(_selected, 0, _num_of_arts);
						
						//Can't select the art you already have selected
						if (_selected != _previous)
							{
							//Make sure the art isn't on cooldown
							if (_s.art_cooldowns[@ _selected] <= 0)
								{
								//Cancel current art
								if (_s.art_selected != -1)
									{
									//10 second cooldown
									_s.art_cooldowns[@ _s.art_selected] = 600;
									_s.art_selected = -1;
									}
							
								//Arts last for 10 seconds
								_s.art_lifetime = 600;
								_s.art_selected = _selected;
								}
							}
						}
					else
						{
						//Cancel current art
						if (_s.art_selected != -1)
							{
							//10 second cooldown
							_s.art_cooldowns[@ _s.art_selected] = 600;
							_s.art_selected = -1;
							}
						}
						
					//VFX
					if (_s.art_selected != -1 && _selected != _previous)
						{
						var _vfx = vfx_create(spr_nspec_monado_arts_symbols, 0, 0, 15, x, y - 64, 2, 0);
						_vfx.fade = true;
						_vfx.shrink = 1.05;
						_vfx.important = true;
						_vfx.vfx_frame = _s.art_selected;
						}
					
					attack_phase++;
					attack_frame = 10;
					anim_frame = 3;
					}
				break;
				}
			//Selecting the Art
			case 2:
				{
				//Animation
				if (attack_frame == 6)
					anim_frame = 4;
			
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */