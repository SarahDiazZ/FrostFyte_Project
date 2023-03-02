function nspec_programmable() {
	//Neutral Special
	/*
	- Hold the button and move the control stick to plot points for the projectile
	- Release the button to shoot off the projectile
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Slowed movement
	friction_gravity(ground_friction, 0.2, 2);
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_nspec_programmable;
				anim_frame = 0;
				anim_speed = 0;
			
				attack_frame = 10;
				
				callback_add(callback_draw_end, nspec_programmable_draw);
				
				//Special variables
				custom_attack_struct.program = [(facing == 1 ? 0 : 180)];
				
				charge = 0;
				return;
				}
			//Startup -> Programming
			case 0:
				{
				//Animation
				if (attack_frame == 6)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = 120;
					}
				break;
				}
			//Programming -> Release
			case 1:
				{
				if (!input_held(INPUT.special, 1) || attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 10;
					var _proj = hitbox_create_projectile_custom(obj_nspec_programmable, 0, 0, 0.4, 0.4, 6, 5, 0.7, 30, 
						(array_length(custom_attack_struct.program) + 1) * 20, SHAPE.circle, 4, 0);
					_proj.custom_projectile_struct.instructions = custom_attack_struct.program;
					}
				else if (--charge <= 0)
					{
					if (stick_tilted(Lstick,DIR.up))
						{
						anim_frame = 5;
						charge = 10;
						array_push(custom_attack_struct.program, 90);
						}
					else
					if (stick_tilted(Lstick,DIR.down))
						{
						anim_frame = 7;
						charge = 10;
						array_push(custom_attack_struct.program, 270);
						}
					else
					if (stick_tilted(Lstick,DIR.right))
						{
						anim_frame = facing == 1 ? 4 : 6;
						charge = 10;
						array_push(custom_attack_struct.program, 0);
						}
					else
					if (stick_tilted(Lstick,DIR.left))
						{
						anim_frame = facing == 1 ? 6 : 4;
						charge = 10;
						array_push(custom_attack_struct.program, 180);
						}
					}
				else if (charge < 5)
					{
					anim_frame = 3;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 6)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
				
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