function item_final_smash_ball_hit() {
	var _hitbox = argument[0];
	//var _hurtbox = argument[1];
	var _s = custom_entity_struct;
	//var _ids = custom_ids_struct;

	//Move when hit by certain hitboxes
	if (object_is(_hitbox.object_index, obj_hitbox_melee) ||
		object_is(_hitbox.object_index, obj_hitbox_projectile) ||
		object_is(_hitbox.object_index, obj_hitbox_magnetbox))
		{
		//Register the hit
		hitbox_register_hit(_hitbox);
		
		//Hitlag
		_hitbox.owner.self_hitlag_frame = _hitbox.base_hitlag;
		self_hitlag_frame = _hitbox.base_hitlag;
		
		var _len = 10;
		var _calc_angle = 90;
		if (!object_is(_hitbox.object_index, obj_hitbox_magnetbox))
			{
			_calc_angle = apply_angle_flipper(_hitbox.angle, FLIPPER.from_player_center_horizontal, _hitbox.owner, id, _len, _hitbox.facing);
			
			//Effects
			hit_vfx_style_create(_hitbox.hit_vfx_style, _calc_angle, _hitbox, _hitbox.base_knockback);
			hit_sfx_play(snd_hit_glitch);
			camera_shake(clamp(_hitbox.base_knockback / 2, 1, 5));
			}
		else
			{
			_len = 0;
			
			//Effects
			hit_vfx_style_create(_hitbox.hit_vfx_style, _calc_angle, _hitbox, 10);
			hit_sfx_play(snd_hit_glitch);
			camera_shake(2);
			}
		
		//Movement
		hsp = lengthdir_x(_len, _calc_angle);
		vsp = lengthdir_y(_len, _calc_angle);
		
		_s.lifetime = min(600, _s.lifetime + 180);
		
		//Breaking
		_s.hp -= _hitbox.damage;
		if (_s.hp <= 0)
			{
			with(_hitbox.player_id)
				{
				final_smash_uses++;
				
				//Fill up the FS meter
				if (array_contains(callback_passive, final_smash_meter_passive) || setting().match_fs_meter)
					{
					custom_passive_struct.fs_meter = 600;
					}
				}
				
			//VFX
			freeze_gameplay(18);
			vfx_create(spr_hit_final_hit, 2, 0, 18, x, y, 2, 41, "VFX_Layer_Below");
			vfx_create_action_lines(18, x, y, 0);
			
			instance_destroy();
			return;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */