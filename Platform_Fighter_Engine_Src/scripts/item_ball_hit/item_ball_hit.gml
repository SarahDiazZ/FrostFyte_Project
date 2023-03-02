function item_ball_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	var _s = custom_entity_struct;
	var _ids = custom_ids_struct;
		
	//Can't be hit when it is held or in hitlag
	if (_ids.item_holder != noone || self_hitlag_frame > 0) then return;
	
	//Can't be hit by other ball instances
	if (object_is(_hitbox.owner.object_index, obj_item_ball)) then return;

	//Move when hit by a hitbox with a knockback angle
	if (object_is(_hitbox.object_index, obj_hitbox_melee) ||
		object_is(_hitbox.object_index, obj_hitbox_projectile) ||
		object_is(_hitbox.object_index, obj_hitbox_windbox))
		{
		//Register the hit
		hitbox_register_hit(_hitbox);
		
		//Hitlag
		_hitbox.owner.self_hitlag_frame = 5;
		
		//Change the ownership
		player_id = _hitbox.player_id;
		
		//Create the hitbox
		any_hitbox_has_hit = false;
		any_hitbox_has_been_blocked = false;
		hitbox_group_reset(0);
		with(_ids.hitbox) instance_destroy();
		
		var _len = 10;
		var _calc_angle = apply_angle_flipper(_hitbox.angle, _hitbox.angle_flipper, _hitbox.owner, id, _len, _hitbox.facing);
		var _facing = sign(lengthdir_x(1, _calc_angle));
		if (_facing != 0) then facing = _facing;
		
		var _new = hitbox_create_melee(0, 0, 0.5, 0.5, 4, 7, 0.5, 5, 45, -1, SHAPE.circle, 0, FLIPPER.sakurai);
		_new.hit_vfx_style = HIT_VFX.normal_weak;
		_new.hit_sfx = snd_hit_weak;
		_new.post_hit_script = item_ball_post_hit;
		_new.custom_hitstun = 20;
		_new.hitlag_scaling = 0;
		_ids.hitbox = _new;
		
		//Make sure the person who threw the ball doesn't get hit by it
		hitbox_group_whitelist_id(_hitbox.player_id, 0);
		
		//Effects
		vfx_create(spr_hit_normal_weak, 1, 0, 14, x, y, 1, _calc_angle, "VFX_Layer_Below");
		hit_sfx_play(snd_hit_weak2);
		camera_shake(3);
		
		//Movement
		hsp = lengthdir_x(_len, _calc_angle);
		vsp = lengthdir_y(_len, _calc_angle);
		}
}
/* Copyright 2023 Springroll Games / Yosi */