///@description Called by obj_game

var _s = custom_entity_struct;
var _ids = custom_ids_struct;

self_hitlag_frame -= 1;
if (self_hitlag_frame > 0) then exit;

//Creating hitboxes
if (_s.planted && !_s.launched)
	{
	_s.water_time += 1;
	if (_s.water_time >= 100)
		{
		_s.water_time = 0;
		with(_ids.water_hitbox_left) instance_destroy();
		with(_ids.water_hitbox_top) instance_destroy();
		with(_ids.water_hitbox_right) instance_destroy();
		//Is the owner above or on the same level?
		if (instance_exists(owner) && owner.y < y - 16)
			{
			//Upwards shot
			_ids.water_hitbox_left = noone;
			_ids.water_hitbox_right = noone;
			_ids.water_hitbox_top = hitbox_create_windbox(0, -16, 0.3, 0.3, 0, 2, 90, 61, SHAPE.square, 1, FLIPPER.standard, true, true, false, 8, true);
			_ids.water_hitbox_top.hit_sfx = -1;
			hitbox_overlay_sprite_set(_ids.water_hitbox_top, spr_dspec_hydrant_water, 0, 0.5, 2, 90, c_white, 1, 1);
			}
		else
			{
			var _face = facing;
			facing = 1;
			//Sideways shots
			_ids.water_hitbox_top = noone;
			_ids.water_hitbox_left = hitbox_create_windbox(-16, 0, 0.3, 0.3, 0, 6, 180, 61, SHAPE.square, 1, FLIPPER.fixed, true, false, true, 0, true);
			_ids.water_hitbox_left.hit_sfx = -1;
			hitbox_overlay_sprite_set(_ids.water_hitbox_left, spr_dspec_hydrant_water, 0, 0.5, 2, 180, c_white, 1, 1);
			_ids.water_hitbox_right = hitbox_create_windbox(16, 0, 0.3, 0.3, 0, 6, 0, 61, SHAPE.square, 1, FLIPPER.fixed, true, false, true, 0, true);
			_ids.water_hitbox_right.hit_sfx = -1;
			hitbox_overlay_sprite_set(_ids.water_hitbox_right, spr_dspec_hydrant_water, 0, 0.5, 2, 0, c_white, 1, 1);
			facing = _face;
			}
		}
	//Move the active hitboxes
	hitbox_move_attached(_ids.water_hitbox_left, -4, 0);
	hitbox_move_attached(_ids.water_hitbox_top, 0, -4);
	hitbox_move_attached(_ids.water_hitbox_right, 4, 0);
	}

//Movement
if (!on_ground(x, y, vsp))
	{
	vsp = min(_s.max_fall_speed, vsp + _s.grav);
	}

if (!_s.planted)
	{
	repeat(abs(vsp))
		{
		//If there's no solid block, move
		if (!on_ground(x, y, vsp)) then y += sign(vsp);		
		else
			{
			vsp = 0;
			_s.planted = true;
			_s.lifetime = 390;
			_s.water_time = 0;
			//Destroy hitboxes
			hitbox_destroy(_ids.drop_hitbox);
			//Create solid block
			collision_flag_set(id, FLAG.solid, true);
			//Create hurtbox
			_ids.hurtbox = hurtbox_create_permanent(spr_dspec_hydrant_obj);
			with(_ids.hurtbox)
				{
				//Scale needs to be larger so projectiles can hit it through the solid block
				image_xscale = 2.5;
				image_yscale = 2.5;
				
				hurtbox_setup
					(
					dspec_hydrant_melee_hit,
					-1,
					-1,
					dspec_hydrant_melee_hit,
					-1,
					-1,
					dspec_hydrant_projectile_hit,
					);
				}
			//Move all players out of blocks just in case
			with(obj_player)
				{
				move_out_of_blocks(90);
				}
			//Visual effects
			vfx_create(spr_dust_impact, 1, 0, 22, x, (bbox_bottom - 1) + 1, 1, 90, "VFX_Layer_Below");
			break;
			}
		}
	}
else if (_s.launched)
	{
	if (sign(hsp) != 0) then _s.angle -= sign(hsp) * 10;
	else _s.angle += 10;
	
	var _results = entity_move_simple(hsp, vsp, false, true, 0.9, false);
	hsp = _results.hsp;
	vsp = _results.vsp;
	}

//Destroy
_s.lifetime -= 1;
if (_s.lifetime <= 0)
	{
	instance_destroy();
	}
else if (y > room_height)
	{
	instance_destroy();
	}
/*
if (!instance_exists(owner))
	{
	log("Owner ", owner, " does not exist!");
	instance_destroy();
	}
*/
/* Copyright 2023 Springroll Games / Yosi */