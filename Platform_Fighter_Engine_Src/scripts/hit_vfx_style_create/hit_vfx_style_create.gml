///@category FX
///@param {int} vfx_style			The hit VFX style to use, from the HIT_VFX enum.
///@param {real} angle				The angle of the hit
///@param {id} hitbox				The id of the hitbox instance
///@param {real} knockback			The amount of knockback
///@param {string} [layer]			The layer to create the VFX on
/*
Creates the given VFX style. The specific coordinates, sprites, etc. vary based on the VFX style.
*/
function hit_vfx_style_create() {
	var _style = argument[0],
		_angle = argument[1],
		_hitbox = argument[2],
		_knock = argument[3],
		_layer = argument_count > 4 ? argument[4] : "VFX_Layer";
	
	//If the user passes an array as the style, it runs each one in turn
	var _styles = [];
	if (is_array(_style))
		{
		_styles = _style;
		}
	else
		{
		_styles = [_style];
		}

	for(var i = 0; i < array_length(_styles); i++)
		{
		switch(_styles[@ i])
			{
			//Standard
			#region Normal Weak
			case HIT_VFX.normal_weak:
				var _vfx = vfx_create(spr_hit_normal_weak, 1, 0, 14, x, y, 1, _angle, _layer);
				_vfx.vfx_blend = make_color_hsv(prng_number(0, 40, 25), 217, 255);
				_vfx.vfx_yscale *= prng_choose(0, -1, 1);

				//Powerful Knockback
				if (_knock > 16)
					{
					vfx_create_action_lines(15, x, y, prng_number(0, 10), _layer);
					}
						
				//Camera shake
				camera_shake(clamp(_knock / 2, 1, 15));
		
				//Hit fade
				fade_value = min(fade_value, 0.7);
				break;
			#endregion
			#region Normal Medium
			case HIT_VFX.normal_medium:
				var _vfx = vfx_create(spr_hit_normal_weak, 1, 0, 14, x, y, 1, _angle, _layer);
				_vfx.vfx_yscale *= prng_choose(0, -1, 1);
				_vfx.vfx_blend = $338bff;
				var _vfx = vfx_create(spr_hit_normal_medium, 1, 0, 15, x, y, 2, _angle + prng_number(0, 15, -15), _layer);
				_vfx.vfx_yscale *= prng_choose(1, -1, 1);
				_vfx.vfx_blend = $66e0ff;
			
				//Powerful Knockback
				if (_knock > 16)
					{
					vfx_create_action_lines(15, x, y, prng_number(0, 10), _layer);
					}
					
				//Camera shake
				camera_shake(clamp(_knock / 2, 1, 15));
		
				//Hit fade
				fade_value = min(fade_value, 0.5);
				break;
			#endregion
			#region Normal Strong
			case HIT_VFX.normal_strong:
				var _vfx = vfx_create(spr_hit_strong_initial_hit, 1, 0, 4, mean(_hitbox.owner.x, x), mean(_hitbox.owner.y, y), 1.5, prng_number(0, 360), _layer);
				_vfx.vfx_blend = $457dff;
				var _vfx = vfx_create(spr_hit_normal_strong, 1, 0, 14, x, y, 1, _angle - 30, _layer);
				_vfx.vfx_blend = make_color_hsv(prng_number(0, 40, 25), 217, 255);
		
				//Powerful Knockback
				if (_knock > 16)
					{
					vfx_create_action_lines(15, x, y, prng_number(0, 10), _layer);
					var _vfx = vfx_create(spr_hit_strong_lightning, 1, 0, 8, x, y, 2, _angle, _layer);
					_vfx.vfx_blend = $457dff;
					}
			
				//Camera shake
				camera_shake(clamp(_knock / 2, 1, 15));
		
				//Hit fade
				fade_value = min(fade_value, 0.3);
				break;
			#endregion
			#region Slash Weak
			case HIT_VFX.slash_weak:
				var _vfx = vfx_create(spr_hit_normal_weak, 1, 0, 14, x, y, 1, _angle, _layer);
				_vfx.vfx_blend = $26ff64;
				_vfx.vfx_yscale *= prng_choose(0, -1, 1);
				var _vfx = vfx_create(spr_hit_slash, 1, 0, 12, x, y, 1.5, _angle, _layer);
				_vfx.vfx_yscale = prng_choose(1, -1, 1);
				_vfx.vfx_alpha = 0.5;
				
				//Powerful Knockback
				if (_knock > 16)
					{
					vfx_create_action_lines(15, x, y, prng_number(0, 10), _layer);
					}	
					
				//Camera shake
				camera_shake(clamp(_knock / 2, 1, 15));
		
				//Hit fade
				fade_value = min(fade_value, 0.7);
				break;
			#endregion
			#region Slash Medium
			case HIT_VFX.slash_medium:
				var _vfx = vfx_create(spr_hit_normal_medium, 1, 0, 15, x, y, 2, _angle + 5, _layer);
				_vfx.vfx_yscale *= prng_choose(0, -1, 1);
				_vfx.vfx_blend = $42f5b0;
				var _vfx = vfx_create(spr_hit_slash2, 1, 0, 16, x, y, 1.5, _angle, _layer);
				_vfx.vfx_blend = $26ff64;
				var _vfx = vfx_create(spr_hit_slash, 1, 0, 12, x, y, 1.5, _angle, _layer);
				_vfx.vfx_yscale = prng_choose(1, -1, 1);
				_vfx.vfx_alpha = 0.5;
				
				//Powerful Knockback
				if (_knock > 16)
					{
					vfx_create_action_lines(15, x, y, prng_number(0, 10), _layer);
					}
				
				//Camera shake
				camera_shake(clamp(_knock / 2, 1, 15));
		
				//Hit fade
				fade_value = min(fade_value, 0.5);
				break;
			#endregion
			#region Slash Strong
			case HIT_VFX.slash_strong:
				var _vfx = vfx_create(spr_hit_normal_strong, 1, 0, 14, x, y, 1, _angle - 30, _layer);
				_vfx.vfx_blend = $42f5b0;
				var _vfx = vfx_create(spr_hit_slash2, 1, 0, 16, x, y, 1.5, _angle + 5, _layer);
				_vfx.vfx_blend = $26ff64;
				var _vfx = vfx_create(spr_hit_slash2, 1, 0, 16, x, y, 1.5, _angle - 5, _layer);
				_vfx.vfx_blend = $26ff64;

				//Powerful Knockback
				if (_knock > 16)
					{
					vfx_create_action_lines(15, x, y, prng_number(0, 10), _layer);
					}

				//Camera shake
				camera_shake(clamp(_knock / 2, 1, 15));
		
				//Hit fade
				fade_value = min(fade_value, 0.3);
				break;
			#endregion
			#region Electric Weak
			case HIT_VFX.electric_weak:
				vfx_create(spr_hit_electric, 1, 0, 26, x, y, 0.5, prng_number(0, 360), _layer);
				
				//Camera shake
				camera_shake(clamp(_knock / 3, 1, 15));
				
				//Hit fade
				fade_value = 0;
				break;
			#endregion
			#region Electric
			case HIT_VFX.electric:
				vfx_create(spr_hit_electric, 1, 0, 26, x, y, clamp(_knock / 12, 0.5, 1.5), prng_number(0, 360), _layer);
				
				//Camera shake
				camera_shake(clamp(_knock / 2, 1, 15));
				
				//Hit fade
				fade_value = 0;
				break;
			#endregion
			#region Magic
			case HIT_VFX.magic:
				var _vfx = vfx_create(spr_hit_magic, 1, 0, 14, x, y, 1, _angle, _layer);
				_vfx.vfx_yscale *= prng_choose(0, -1, 1);
				_vfx.vfx_blend = make_color_hsv(prng_number(0, 255, 180), 87, 255);
				var _vfx = vfx_create(spr_hit_darkness, 1, 0, 29, x, y, 2, _angle, _layer);
				_vfx.vfx_yscale *= prng_choose(1, -1, 1);

				//Camera shake
				camera_shake(clamp(_knock / 3, 1, 15));
		
				//Hit fade
				fade_value = min(fade_value, 0.5);
				break;
			#endregion
			#region Grab
			case HIT_VFX.grab:
				//With the target
				var _dir = prng_number(0, 360);
				var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(_hitbox.owner.x, x), mean(_hitbox.owner.y, y), 3, _dir, "VFX_Layer_Below");
				_vfx.shrink = 0.88;
				_vfx.spin = 9;
				_vfx.fade = true;
				var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(_hitbox.owner.x, x), mean(_hitbox.owner.y, y), 3, _dir + 180, "VFX_Layer_Below");
				_vfx.shrink = 0.88;
				_vfx.spin = 9;
				_vfx.fade = true;

				//Camera shake
				var _shake = clamp(2 + ((damage / 20) * weight_multiplier) / 2, 1, 15);
				camera_shake(_shake);
				break;
			#endregion
			#region Explosion
			case HIT_VFX.explosion:
				vfx_create(spr_hit_explosion, 1, 0, 18, x, y, 1, 0, _layer);
				vfx_create_action_lines(15, x, y, prng_number(0, 10), _layer);

				//Camera shake
				camera_shake(clamp(_knock / 1.8, 1, 15));
				
				//Hit fade
				fade_value = min(fade_value, 0.3);
				break;
			#endregion
			#region Splash
			case HIT_VFX.splash:
				var _vfx = vfx_create(spr_hit_water, 1, 0, 28, x, y, 2, _angle, _layer);
				_vfx.vfx_yscale *= prng_choose(0, -1, 1);
				_vfx.vfx_blend = $fab387;

				//Camera shake
				camera_shake(clamp(_knock / 1.8, 1, 15));
				break;
			#endregion
			
			//Single Effects
			#region Shield
			case HIT_VFX.shield:
				vfx_create(spr_hit_shield, 1, 0, 12, mean(_hitbox.owner.x, x), mean(_hitbox.owner.y, y), 1, prng_number(0, 360));
				break;
			#endregion
			#region Shield Projectile
			case HIT_VFX.shield_projectile:
				vfx_create(spr_hit_shield, 1, 0, 12, x, y, 1, prng_number(0, 360));
				break;
			#endregion
			#region Spin
			case HIT_VFX.spin:
				vfx_create(spr_hit_spin, 1, 0, 28, mean(_hitbox.owner.x, x), mean(_hitbox.owner.y, y), 1.5, _angle - 30, _layer);
				break;
			#endregion
			#region Lines
			case HIT_VFX.lines:
				vfx_create_action_lines(15, x, y, prng_number(0, 10), _layer);
				break;
			#endregion
			#region Emphasis
			case HIT_VFX.emphasis:
				//Background clear
				var _time = max(20, obj_stage_manager.background_clear_frame);
				background_clear_activate(_time, palette_color_get(_hitbox.owner.palette_data, 0));
				//Hit fade
				fade_value = 0;
				break;
			#endregion
			#region Shine
			case HIT_VFX.shine:
				var _vfx = vfx_create(spr_shine_attack_long, 1, 0, 16, _hitbox.x, _hitbox.y, 2, _angle, _layer);
				_vfx.spin = 1;
				break;
			#endregion
	
			//Custom
			#region Custom
			case HIT_VFX.custom:
				//This is a special VFX style that will treat the next value in the array as a script
				i += 1;
				if (i < array_length(_styles))
					{
					if (script_exists(_styles[@ i]))
						{
						script_execute(_styles[@ i], _angle, _hitbox, _knock, _layer);
						}
					else
						{
						crash("[hit_vfx_style_create] The value following HIT_VFX.custom in the array was not a valid script index (", _styles[@ i], ")");
						}
					}
				else
					{
					crash("[hit_vfx_style_create] The HIT_VFX.custom style must be used in an array, and have a script index immediately after it");
					}
				break;
			#endregion
	
			//None
			#region None
			case HIT_VFX.none:
			default: break;
			#endregion
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */