///@description Called by obj_game

var _s = custom_entity_struct;
var _ids = custom_ids_struct;

if (_s.explosion_time > 0)
	{
	_s.explosion_time--;
	if (_s.explosion_time <= 0)
		{
		instance_destroy();
		exit;
		}
	}
else if (_ids.attached == noone)
	{
	//Falling
	hsp = approach(hsp, 0, 0.1);
	vsp = min(vsp + _s.grav, _s.max_fall_speed);
	
	repeat(abs(hsp))
		{
		if (!collision(x + sign(hsp), y, [FLAG.solid])) then x += sign(hsp);
		else
			{
			hsp = 0;
			break;
			}
		}
	repeat(abs(vsp))
		{
		if (!on_ground(x, y, vsp)) then y += sign(vsp);
		else
			{
			hsp = 0;
			vsp = 0;
			_s.grounded = true;
			break;
			}
		}
		
	//Attach to players nearby
	if (!_s.grounded)
		{
		//Get collisions with nearby players
		ds_list_clear(temp_list_get());
		if (collision_circle_list(x, y, 20, obj_player, false, true, temp_list_get(), true))
			{
			for(var i = 0; i < ds_list_size(temp_list_get()); i++)
				{
				var _inst = temp_list_get()[| i];
				//Cannot attach to owner
				if (_inst != noone && _inst != owner)
					{
					//Cannot attach to dead or invincible players
					with(_inst)
						{
						if (!is_knocked_out() && hurtbox.inv_type != INV.invincible)
							{
							_ids.attached = _inst;
							break;
							}
						}
					}
				}
			}
		}
	}
else        
	{
	//Follow the player, unless it is already exploding
	if (_s.explosion_time == -1)
		{
		x = _ids.attached.x;
		y = _ids.attached.y;
		}
		
	//Auto exploding
	_s.auto_explode_timer -= 1;
	if (_s.auto_explode_timer == 15)
		{
		game_sound_play(snd_c4);
		}
		
	if (_s.auto_explode_timer <= 0)
		{
		_s.explosion_time = 10;
						
		//Sweetspot
		var _hitbox = hitbox_create_melee(0, 0, 1, 1, 5, 7, 0.6, 5, 90, 1, SHAPE.circle, 0);
		_hitbox.hit_sfx = snd_hit_explosion4;
		_hitbox.hit_vfx_style = HIT_VFX.explosion;
		_hitbox.custom_hitstun = 20;
						
		//Weak hitbox
		var _hitbox = hitbox_create_melee(0, 0, 2.5, 2.5, 3, 6, 0.5, 3, 90, 5, SHAPE.circle, 0);
		_hitbox.hit_sfx = snd_hit_explosion4;
		_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
		_hitbox.custom_hitstun = 20;
						
		//Explosion VFX
		var _vfx = vfx_create(spr_dspec_c4_explosion, 1, 0, 34, x, y, 2, 0);
		_vfx.important = true;
		game_sound_play(snd_hit_explosion2);
		camera_shake(3);
		}
	}
	
//Animation
if (_s.explosion_time > 0)
	{
	visible = false;
	}
else if (_s.grounded)
	{
	image_index += 0.1;
	if (image_index >= 4 || image_index < 2) then image_index = 2;
	}
else
	{
	image_index += 0.1;
	if (image_index >= 2) then image_index = 0;
	
	if (_s.auto_explode_timer <= 120)
		{
		image_index = 4;
		}
	}
	
//Destroy if the owner is dead or the attached player is dead
with(owner)
	{
	if (is_knocked_out())
		{
		instance_destroy(other);
		exit;
		}
	}
with(_ids.attached)
	{
	if (is_knocked_out())
		{
		instance_destroy(other);
		exit;
		}
	}
	
//Destroy if it falls under the stage
if (bbox_top > room_height)
	{
	instance_destroy();
	exit;
	}
/* Copyright 2023 Springroll Games / Yosi */