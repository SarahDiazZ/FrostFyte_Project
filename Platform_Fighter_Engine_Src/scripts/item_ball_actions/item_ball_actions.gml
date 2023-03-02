function item_ball_actions() {
	var _action = argument[0];
	var _s = custom_entity_struct;
	var _ids = custom_ids_struct;
	var _player = _ids.item_holder;
	
	switch(_action)
		{
		case ITEM_ACTION.picked_up:
			_s.lifetime = 600;
			
			with(_ids.hitbox) instance_destroy();
	
			//Snap to the holder's location
			var _player = _ids.item_holder;
			x = _player.x + (_player.item_hold_x * _player.facing);
			y = _player.y + (_player.item_hold_y);
			break;
		case ITEM_ACTION.thrown:
			_s.lifetime = 600;
		
			//Set the speed
			var _dir = _player.item_throw_direction;
			if (_dir == 0)
				{
				hsp = 12;
				vsp = -4;
				}
			else if (_dir == 180)
				{
				hsp = -12;
				vsp = -4;
				}
			else if (_dir == 90)
				{
				hsp = 0;
				vsp = -16;
				}
			else if (_dir == 270)
				{
				hsp = 0;
				vsp = 12;
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
			facing = _player.facing;
			var _hitbox = hitbox_create_melee(0, 0, 0.5, 0.5, 4, 7, 0.5, 5, 45, -1, SHAPE.circle, 0, FLIPPER.sakurai);
			_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
			_hitbox.hit_sfx = snd_hit_weak;
			_hitbox.post_hit_script = item_ball_post_hit;
			_hitbox.custom_hitstun = 20;
			_hitbox.hitlag_scaling = 0;
			_ids.hitbox = _hitbox;
			
			//Make sure the person who threw the ball doesn't get hit by it
			hitbox_group_whitelist_id(_player, 0);
			break;
		}
}
/* Copyright 2023 Springroll Games / Yosi */