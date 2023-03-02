function nspec_bow() {
	//Neutral Special
	/*
	- Charge the attack to fire a piercing arrow
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Actions / Cancels
	if (on_ground())
		{
		friction_gravity(ground_friction, grav, max_fall_speed);
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
				anim_sprite = spr_nspec_bow;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 40;
				reverse_b();
				return;
				}
			//Startup / Shoot
			case 0:
				{
				//B reverse
				if (attack_frame == 36)
					{
					b_reverse();
					}
				
				//Animation
				if (attack_frame == 30)
					anim_frame = 1;
				if (attack_frame == 20)
					anim_frame = 2;
				if (attack_frame == 10)
					anim_frame = 3;
				if (attack_frame == 8)
					anim_frame = 4;
				if (attack_frame == 6)
					anim_frame = 5;
				if (attack_frame == 4)
					anim_frame = 6;
				if (attack_frame == 2)
					anim_frame = 7;
				if (attack_frame == 0 && obj_game.current_frame % 2 == 0)
					{
					if (anim_frame == 7)
						anim_frame = 8;
					else
						anim_frame = 7;
					}
				
				if (attack_frame <= 34 && !input_held(INPUT.special))
					{
					anim_frame = 9;
				
					var _charge = 1 - (attack_frame / 34);
					var _fully_charged = (attack_frame == 0);
					var _grav =		_fully_charged ? 0	: 0.17 - (0.17 * _charge);
					var _hsp =		_fully_charged ? 25	: 10 + round(5 * _charge);
					var _damage =	_fully_charged ? 12	: 4 + round(6 * _charge);
					var _hitlag =	_fully_charged ? 10	: 3 + round(5 * _charge);
					var _kb =		_fully_charged ? 7	: 4 + round(3 * _charge);
					var _scaling =	_fully_charged ? 1	: 0.3 + (0.3 * _charge);
					var _proj = hitbox_create_projectile_custom(obj_nspec_bow_arrow, 24, 0, 0.2, 0.2, _damage, _kb, _scaling, 45, 180, SHAPE.circle, _hsp, 0, FLIPPER.sakurai);
					_proj.destroy_on_blocks = true;
					_proj.destroy_on_hit = !_fully_charged;
					_proj.grav = _grav;
					_proj.base_hitlag = _hitlag;
					_proj.hit_sfx = _fully_charged ? snd_hit_strong2 : snd_hit_weak2;
					_proj.hit_vfx_style = _fully_charged ? [HIT_VFX.explosion, HIT_VFX.slash_medium] : HIT_VFX.slash_medium;
					_proj.knockback_state = _fully_charged ? PLAYER_STATE.balloon : PLAYER_STATE.hitstun;
					_proj.can_lock = !_fully_charged;
				
					attack_phase++;
					attack_frame = 30;
					}
				break;
				}
			//Finish
			case 1:
				{
				//Animation
				if (attack_frame == 25)
					anim_frame = 10;
				if (attack_frame == 15)
					anim_frame = 11;
			
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