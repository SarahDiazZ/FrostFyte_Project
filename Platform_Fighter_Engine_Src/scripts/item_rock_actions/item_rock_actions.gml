function item_rock_actions() {
	var _action = argument[0];
	var _s = custom_entity_struct;
	var _ids = custom_ids_struct;
	var _player = _ids.item_holder;
	
	switch(_action)
		{
		case ITEM_ACTION.picked_up:
			_s.lifetime = 600;
			
			collision_flag_set(id, FLAG.solid, false);
			with(_ids.hitbox) instance_destroy();
	
			//Snap to the holder's location
			var _player = _ids.item_holder;
			x = _player.x + (_player.item_hold_x * _player.facing);
			y = _player.y + (_player.item_hold_y);
			break;
		case ITEM_ACTION.thrown:
			_s.lifetime = 600;
		
			//Set the speed, and push the player backwards some
			var _dir = _player.item_throw_direction
			if (_dir == 0)
				{
				hsp = 10;
				vsp = -5;
				with(_player) speed_set(-1, 0, true, true);
				}
			else if (_dir == 180)
				{
				hsp = -10;
				vsp = -5;
				with(_player) speed_set(1, 0, true, true);
				}
			else if (_dir == 90)
				{
				hsp = 0;
				vsp = -15;
				with(_player) speed_set(0, 1, true, true);
				}
			else if (_dir == 270)
				{
				hsp = 0;
				vsp = 10;
				with(_player) speed_set(0, -7, true, false);
				}
			else if (_dir == -1)
				{
				//Drop
				hsp = 0;
				vsp = 1;
				}
			
			//Create the hitbox
			any_hitbox_has_hit = false;
			any_hitbox_has_been_blocked = false;
			hitbox_group_reset(0);
			with(_ids.hitbox) instance_destroy();
			var _angle = point_direction(0, 0, hsp, vsp);
			var _hitbox = hitbox_create_melee(0, 0, 0.75, 0.75, 10, 8, 0.6, 10, _angle, -1, SHAPE.square, 0, FLIPPER.fixed);
			_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
			_hitbox.hit_sfx = snd_hit_strong;
			_hitbox.post_hit_script = item_rock_post_hit;
			_hitbox.custom_hitstun = 30;
			_hitbox.hitlag_scaling = 0;
			_ids.hitbox = _hitbox;
			
			//Make sure the person who threw the rock doesn't get hit by it
			hitbox_group_whitelist_id(_player, 0);
			break;
		}
}
/* Copyright 2023 Springroll Games / Yosi */