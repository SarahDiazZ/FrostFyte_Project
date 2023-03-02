function nspec_hadoken_detect_script() {
	var _target = argument[0];
	var _hitbox = argument[1];
	var _hurtbox = argument[2];
	
	//Check that the owner isn't the same
	//Normally hitbox_can_hit_hurtbox checks this, but because the hitbox is owned by the entity, it doesn't quite work
	if (owner == _hurtbox.owner) then return;
	
	//Check invulnerability
	switch(_hurtbox.inv_type)
		{
		//Create the hitbox
		default:
		case INV.normal:
		case INV.heavyarmor:
		case INV.superarmor:
		case INV.shielding:
		case INV.counter:
			with(_hitbox.owner)
				{
				hitbox_destroy(_hitbox); //Destroy the detectbox
				var _c = custom_entity_struct;
				
				//Light
				if (_c.type == 0)
					{
					_c.lifetime = 2;
					
					var _hitbox = hitbox_create_melee(0, 0, 0.5, 0.5, 5, 6, 0.1, 3, 45, 1, SHAPE.circle, 1, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = [HIT_VFX.magic, HIT_VFX.normal_weak];
					_hitbox.can_lock = true;
					
					hitbox_group_whitelist_id(owner, 1);
					
					with(_hitbox)
						{
						event_user(Game_Event_Step);
						}
					}
					
				//Heavy
				else if (_c.type == 1 && _c.phase == 0)
					{
					_c.phase = 1;
					_c.lifetime = 13;
					
					hsp = hsp div 2;

					var _hitbox = hitbox_create_melee(0, 0, 0.5, 0.5, 1, 4, 0, 1, 0, 11, SHAPE.circle, 1, FLIPPER.autolink_center);
					_hitbox.hit_vfx_style = [HIT_VFX.normal_medium];
					_hitbox.asdi_multiplier = 0;
					_hitbox.di_angle = 0;
					_hitbox.techable = false;
					_hitbox.hitlag_scaling = 0;
					_hitbox.custom_hitstun = 5;
					_hitbox.background_clear_allow = false;

					hitbox_group_whitelist_id(owner, 1);
					
					with(_hitbox)
						{
						event_user(Game_Event_Step);
						}
					}
					
				//EX
				else if (_c.type == 2 && _c.phase == 0)
					{
					_c.phase = 1;
					_c.lifetime = 13;
					
					hsp = hsp div 2;

					var _hitbox = hitbox_create_melee(0, 0, 0.7, 0.7, 1, 4, 0, 1, 0, 11, SHAPE.circle, 1, FLIPPER.autolink_center);
					_hitbox.hit_vfx_style = [HIT_VFX.normal_medium];
					_hitbox.asdi_multiplier = 0;
					_hitbox.di_angle = 0;
					_hitbox.techable = false;
					_hitbox.hitlag_scaling = 0;
					_hitbox.custom_hitstun = 5;
					_hitbox.background_clear_allow = false;

					hitbox_group_whitelist_id(owner, 1);
					}
				}
			break;
		
		//Destroy
		case INV.parry_shield:
		case INV.deactivate:
			hitbox_destroy(_hitbox);
			break;
			
		//Do nothing
		case INV.invincible:
			break;
			
		//Reflection
		case INV.parry_press:
			with(_hitbox.owner)
				{
				entity_owner_change(_target);
				hsp = -hsp * parry_press_reflect_multiplier;
				vsp = -vsp * parry_press_reflect_multiplier;
				facing *= -1;
				}
			//Trigger the parry
			parry_press_trigger(_hitbox, false, _target);
			break;
		case INV.powershielding:
			with(_hitbox.owner)
				{
				entity_owner_change(_target);
				hsp = -hsp * powershield_reflect_multiplier;
				vsp = -vsp * powershield_reflect_multiplier;
				facing *= -1;
				}
			_target.state_frame = 0;
			//Effects
			vfx_create(spr_hit_powershield, 1, 0, 16, _target.x, _target.y, 1, 0, "VFX_Layer_Below");
			vfx_create_action_lines(10, _target.x, _target.y, prng_number(0, 10));
			hit_sfx_play(snd_parry);
			break;
		case INV.reflector:
			with(_hitbox.owner)
				{
				entity_owner_change(_target);
				//Reflect
				hsp = -hsp * reflector_speed_multiplier;
				vsp = -vsp * reflector_speed_multiplier;
				custom_entity_struct.lifetime += reflector_lifetime_extension;
				facing *= -1;
				//Effects
				hit_sfx_play(snd_parry);
				}
			break;
		}
}
/* Copyright 2023 Springroll Games / Yosi */