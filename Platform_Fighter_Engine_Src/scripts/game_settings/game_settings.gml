///@category Settings
/*
This script contains all of the default game settings for the game.
It is automatically run at the start of the game.
*/
#region Variable
/*
- These settings can be changed during gameplay
- Access using setting().property syntax
*/
function setting() {
	static _settings = 
		{
		//Game
		debug_mode_enable :					false, //{bool} Whether the game will be run in debug mode or not. Debug mode enables players to use the function keys to turn on debug overlays.
		replay_mode :						false, //{bool} Whether the game is playing back a replay or not.
		replay_record :						true, //{bool} Whether the game can record replays or not.
		match_stage :						rm_warpgate, //{asset} The stage the match will use.
		match_stock :						match_stock_default, //{int} The number of stocks each player in the match will start with. The default value is <match_stock_default>.
		match_time :						match_time_default, //{real} The amount of time the match will take. The default value is <match_time_default>.
		match_stamina :						match_stamina_default, //{int} The amount of stamina each player in the match will start with. The default value is <match_stamina_default>.
		match_team_mode :					match_team_mode_default, //{bool} Whether the match uses teams or not. The default value is <match_team_mode_default>.
		match_team_attack :					match_team_attack_default, //{bool} Whether players on the same team can attack each other or not. The default value is <match_team_attack_default>.
		match_items_enable :				match_items_enable_default, //{bool} Whether items are enabled or not. The default value is <match_items_enable_default>.
		match_items_frequency :				match_items_frequency_default, //{int} A number from 0-100 that determines the frequency of item spawning, if <match_items_enable> is on. The default value is <match_items_frequency_default>.
		match_fs_meter :					match_fs_meter_default, //{bool} Whether Final Smash meters are enabled or not. The default value is <match_fs_meter_default>.
		match_screen_wrap :					match_screen_wrap_default, //{bool} Whether players should wrap around the screen instead of getting KO'ed. The default value is <match_screen_wrap_default>. Warning: This should only be used in Time or Stamina matches, and will change the knockback formula for Stamina matches.
		match_ex_meter :					match_ex_meter_default, //{bool} Whether EX meters are enabled or not. The default value is <match_ex_meter_default>.
		debug_fps :							false, //{bool} Whether to show FPS numbers in the top right corner or not.
		performance_mode :					false, //{bool} Performance mode turns off certain visual effects to increase performance.
		disable_shaders :					false, //{bool} Whether to disable all shaders or not.
		local_frame_skip :					true, //{bool} Whether frames can be skipped locally if the game is running under 60fps or not.
		//Visibility
		show_hitboxes :						false, //{bool} Whether to make hitboxes visible or not.
		show_hurtboxes :					false, //{bool} Whether to make hurtboxes visible or not.
		show_collision_boxes :				false, //{bool} Whether to make collision boxes visible or not.
		show_launch_trajectories :			false, //{bool} Whether to make the launch trajectory of the last move visible or not.
		show_damage_numbers :				false, //{bool} Whether to show damage numbers when attacks hit or not.
		show_combos :						false, //{bool} Whether to show the combo counter or not.
		show_hud :							true, //{bool} Whether to make the HUD visible or not.
		show_overhead_name :				true, //{bool} Whether to show names over players' heads or not.
		show_overhead_damage :				false, //{bool} Whether to show damage over players' heads or not.
		show_overhead_arrow :				false, //{bool} Whether to show an arrow over players' heads or not.
		show_hitbox_trails :				false, //{bool} Whether to draw trails to show where hitboxes were on previous frames.
		show_shieldstun :					false, //{bool} Whether to show the number of shieldstun frames on hit or not.
		show_frame_advantage :				false, //{bool} Whether to show the number of advantage frames for attack on hit or not.
		show_offscreen_radar :				true, //{bool} Whether to show the offscreen radar or not.
		show_timer :						true, //{bool} Whether to show the time left in the match or not.
		//Screen
		daynight_cycle_enable :				false, //{bool} Whether the day/night cycle will be used on the current stage or not.
		stage_background_color :			c_ltgray, //{color} The background color drawn to the game surface for the current stage.
		green_screen_color :				0, //{int} The color for the green screen to use. 0=None, 1=Green, 2=Blue, 3=Red, 4=Black, 5=White.
		background_is_static :				false, //{bool} Whether the background array for <obj_stage_manager> is constant during matches or not. If true, <game_state_save> will not save the background array.
		screen_shader_script :				-1, //{asset} The script to run that will set a shader for the entire screen, and pass in any necessary uniforms.
		//Camera
		camera_move_speed :					0.1, //{real} The max speed the camera can move at, in percent (from 0 to 1).
		camera_y_offset :					-16, //{int} The vertical offset of the camera.
		camera_zoom_enable :				false, //{bool} Whether the camera can zoom or not.
		camera_zoom_speed_out :				0.05, //{real} The speed the camera can zoom out at, in percent (from 0 to 1).
		camera_zoom_speed_in :				0.01, //{real} The speed the camera can zoom in at, in percent (from 0 to 1).
		//Surfaces
		//Outlines
		//Player HUD
		//Countdown Time
		//End Time
		//Pausing
		pause_allow :						true, //{bool} Whether the game can be paused during local matches or not.
		pause_hold_input :					false, //{bool} Whether players have to hold the pause button for the <pause_hold_time> instead of simply pressing it.
		//VFX
		knockback_trails_enable :			true, //{bool} Whether knockback cloud trails are created or not.
		//Input Buffer
		//Control Stick
		//Menus
		//Knockback
		//Knockdown
		//DI
		//Angles
		//Jumping
		//Landing
		//Smash Attacks
		//Grabs
		//Sound
		volume_music :						1.0, //{real} The volume of the music, from 0 to 1. Anything over 1 will make the music louder than normal.
		volume_sound_effects :				1.0, //{real} The volume of the sound effects, from 0 to 1. Anything over 1 will make the sound effects louder than normal.
		volume_menu :						1.0, //{real} The volume of the menu music and sound effects, from 0 to 1.Anything over 1 will make the sounds louder than normal.
		stereo_sound_effects :				true, //{bool} Whether the audio should be stereo or not.
		//Collisions
		slope_collisions_enable :			true, //{bool} Whether slopes work or not. This can be turned off on stages without slopes to slightly boost performance.
		//Shielding
		//Parry Press
		//Rolling
		//Teching
		//Reflectors
		//Ledges
		//Wall Jumps
		//Airdodges
		//Wavedashing
		//Moonwalking
		//Knockouts
		//Screen wrap
		//EX Moves
		//Hitbox Drawing
		//Animation
		//Aerial State
		//Items
		//CSS
		//Win Screen
		//Online
		//Replays
		//Clips
		clip_record :						false, //{bool} Whether the game can record clips or not.
		};
	return _settings;
}
#endregion

#region Constant
/*
- These settings cannot be changed during gameplay
*/
//Game
#macro show_debug_logs						false //{bool} Whether messages from the <log> function are displayed in the console. Debug mode must also be enabled.
#macro max_players							8 //{int} The maximum number of players.
#macro max_teams							4 //{int} The maximum number of teams.
#macro airdodge_type						AIRDODGE_TYPE.momentum_stop //{int} The type of airdodge to use, from the enum AIRDODGE_TYPE.
#macro shield_type							SHIELD_TYPE.perfect_shield_start //{int} The type of shield to use, from the enum SHIELD_TYPE.
#macro wall_jump_type						WALL_JUMP_TYPE.jump_press //{int} The type of wall jump to use, from the enum WALL_JUMP_TYPE.
#macro ledge_type							LEDGE_TYPE.hog //{int} The type of ledge to use, from the enum LEDGE_TYPE.
#macro hitstun_type							HITSTUN_TYPE.normal //{int} The hitstun formula to use, from the enum HITSTUN_TYPE.
#macro knockdown_type						KNOCKDOWN_TYPE.normal //{int} The type of knockdown to use, from the enum KNOCKDOWN_TYPE.
#macro item_system_type						ITEM_SYSTEM_TYPE.standard //{int} The item system to use, from the enum ITEM_SYSTEM_TYPE.
#macro player_state_log_size				5 //{int} The number of states that are stored for the debug state log.
//Visibility
//Screen
#macro screen_width							960 //{int} The width of the game window.
#macro screen_height						540 //{int} The height of the game window.
//Camera
#macro camera_width_start					960 //{real} The starting width of the game camera.
#macro camera_height_start					540 //{real} The starting height of the game camera.
#macro camera_boundary						120 //{real} The boundary around the edge of the blastzones that the camera can't go past.
#macro camera_ratio							(camera_width_start / camera_height_start) //{real} DO NOT CHANGE. The ratio of the camera width and height.
#macro camera_zoom_pad_scale				1.7 //{real} The padding around the camera when zooming, in percent.
#macro camera_zoom_pad_xscale				0.0 //{real} The horizontal padding multiplier.
#macro camera_zoom_pad_yscale				0.1 //{real} The vertical padding multiplier.
#macro camera_width_max						(room_width) //{real} The maximum width of the camera.
#macro camera_height_max					(room_width / camera_ratio) //{real} The maximum height of the camera.
#macro camera_width_min						480 //{real} The minimum width of the camera.
#macro camera_height_min					270 //{real} The minimum height of the camera.
#macro camera_rounding_enable				true //{real} Whether the camera coordinates are rounded or not.
#macro camera_special_zoom_enable			false //{bool} Whether the finishing blow effect causes the camera to zoom or not.
#macro camera_special_zoom_speed_out		0.15 //{real} The speed at which the camera can zoom out during a special zoom, in percent.
#macro camera_special_zoom_speed_in			0.4 //{real} The speed at which the camera can zoom in during a special zoom, in percent.
#macro camera_special_zoom_width			480 //{real} The desired width of the camera during a special zoom.
#macro camera_special_zoom_height			270 //{real} The desired height of the camera during a special zoom.
#macro camera_death_shake					15 //{real} The amount the camera shakes when a player is knocked out.
//Surfaces
#macro game_surface_enable					false //{bool} Whether the game surface is enabled or not. Allows you to use screen effects, such as the daynight cycle.
#macro object_surface_size					400 //{int} The width and height of the surface objects with outlines draw to, in pixels.
#macro object_surface_size_half				(object_surface_size / 2) //{int} Half the size of the object surface.
//Outlines
#macro player_outline						true //{bool} Whether players have outlines or not.
#macro projectile_outline					false //{bool} Whether projectiles have outlines or not.
#macro entity_outline						true //{bool} Whether entities have outlines or not.
#macro item_outline							true //{bool} Whether items have outlines or not.
//Player HUD
#macro player_hud_type						HUD_TYPE.normal //{int} The type of HUD to use, from the HUD_TYPE enum.
#macro player_hud_padding_bottom			54 //{int} The distance from the bottom of the screen that the HUD is drawn.
#macro player_hud_scale						2 //{real} The scaling multiplier applied to sprites on the HUD.
#macro player_hud_profile_names				true //{bool} Whether to show profiles names instead of character names on the HUD or not.
#macro player_hud_damage_percent			false //{bool} Whether to show the % sign after the damage number or not.
#macro hud_1v1_scoreboard_enable			true //{bool} Whether the scoreboard is shown between stocks in a 1v1 match or not.
//Countdown Time
#macro countdown_start_time					50 //{int} The number of frames between each number in the match start countdown.
//End Time
#macro game_end_time						130 //{int} The number of frames the game waits when the match ends.
//Pausing
#macro pause_hold_time						45 //{in} The number of frames players have to hold the pause button to pause the game, if <pause_hold_input> is true.
//VFX
//Input Buffer
#macro buffer_time_standard					6 //{int} The number of frames inputs will be saved after being pressed.
#macro buffer_time_max						20 //{int} The maximum number of frames inputs can be saved for.
#macro tech_buffer_time						20 //{int} The number of frames a tech input lasts.
#macro tech_lockout_time					40 //{int} The number of frames after a tech input until the player can input another one.
#macro tech_buffer_before_hitstun			true //{bool} Whether players can buffer a tech before hitstun begins or not.
#macro fastfall_buffer_time					12 //{int} The number of frames a fastfall can be buffered.
#macro fastfall_attack_hold					false //{bool} Whether the player can fastfall during an attack by simply holding downwards.
#macro double_tap_buffer_time				10 //{int} The number of frames between two presses that will count them as a "double tap" (for keyboard players with the "double tap to run" setting).
//Control Stick
#macro stick_check_type						STICK_CHECK_TYPE.backwards //{int} The stick check type to use, from the enum STICK_CHECK_TYPE.
#macro stick_check_frames					3 //{int} The number of frames to use to determine the speed of the control stick.
#macro stick_tilt_amount					0.4 //{real} The "tilt" threshold of the left stick.
#macro stick_flick_speed					0.50 //{real} The speed the left stick needs to be moved at to count as a flick.
#macro stick_flick_amount					0.75 //{real} The "flick" threshold of the left stick.
#macro stick_flick_buff						6 //{int} The number of frames a flick will be saved.
#macro stick_flick_cooldown					1 //{int} The number of frames before a control stick can be flicked again. This is mainly to prevent bugs on keyboard controls.
#macro stick_direction_sens					65 //{real} The range, in degrees, of stick directions. Anything less than 45 will cause diagonals to not register properly.
#macro stick_direction_motion_sens			23 //{real} The range, in degrees, of stick motion directions. Anything less than 22.5 will cause some in-between directions to not register properly.
#macro stick_reverse_b_time					4 //{int} The number of frames an input is buffered for a reverse B.
#macro rstick_tilt_amount					0.4 //{real} The "tilt" threshold of the right stick.
#macro rstick_flick_speed					0.4 //{real} The speed the right stick needs to be moved at to count as a flick.
#macro rstick_flick_amount					0.7 //{real} The "flick" threshold of the right stick.
//Menus
#macro menu_confirm_button					gp_face1 //{int} The gamepad button(s) to "confirm" in menus.
#macro menu_back_button						gp_face2 //{int} The gamepad button(s) to "back" in menus.
#macro menu_remove_button					gp_face4 //{int} The gamepad button(s) to "remove" in menus.
#macro menu_option_button					gp_face3 //{int} The gamepad button(s) to "option" in menus.
#macro menu_page_next_button				[gp_shoulderr, gp_shoulderrb] //{int} The gamepad button(s) to go to the next page in menus.
#macro menu_page_last_button				[gp_shoulderl, gp_shoulderlb] //{int} The gamepad button(s) to go to the previous page in menus.
#macro menu_start_button					gp_start //{int} The gamepad button(s) to "start" in menus.
#macro menu_select_button					gp_select //{int} The gamepad button(s) to "select" in menus.

#macro menu_confirm_key						vk_enter //{int} The keyboard key(s) to "confirm" in menus.
#macro menu_back_key						vk_backspace //{int} The keyboard key(s) to "back" in menus.
#macro menu_remove_key						vk_control //{int} The keyboard key(s) to "remove" in menus.
#macro menu_option_key						vk_shift //{int} The keyboard key(s) to "option" in menus.
#macro menu_page_next_key					ord("X") //{int} The keyboard key(s) to go to the next page in menus.
#macro menu_page_last_key					ord("Z") //{int} The keyboard key(s) to go to the previous page in menus.
#macro menu_start_key						vk_space //{int} The keyboard key(s) to "start" in menus.
#macro menu_select_key						vk_tab //{int} The keyboard key(s) to "select" in menus.

#macro menu_left_key						[vk_left, ord("A")] //{int} The keyboard key to move the cursor left in menus.
#macro menu_right_key						[vk_right, ord("D")] //{int} The keyboard key to move the cursor right in menus.
#macro menu_up_key							[vk_up, ord("W")] //{int} The keyboard key to move the cursor up in menus.
#macro menu_down_key						[vk_down, ord("S")] //{int} The keyboard key to move the cursor down in menus.

#macro menu_cursor_speed					8 //{real} The speed at which cursors move on menus.
//Knockback
#macro knockback_scaling_multiplier			0.12 //{real} The multiplier used in <calculate_knockback> for the standard knockback formula.
#macro knockback_max						100 //{real} The maximum amount of knockback a player can take.
#macro hitstun_multiplier					0.85 //{real} The default hitstun multiplier to use in <calculate_hitstun>.
#macro hitstun_base_multiplier				4 //{real} The base hitstun multiplier used in <calculate_hitstun>.
#macro hitstun_weight_multiplier			0.6 //{real} The hitstun weight multiplier used in <calculate_hitstun>.
#macro hitstun_damage_multiplier			0.24 //{real} The hitstun damage multiplier used in <calculate_hitstun>.
#macro hitstun_knockback_multiplier			4 //{real} The hitstun knockback multiplier used in <calculate_hitstun>.
#macro hitstun_hp_increase_max				200 //{int} The maximum number of frames that can be added to the hitstun based on how much damage the target has taken. Used in <calculate_hitstun>.
#macro hitlag_multiplier					1.0 //{real} The hitlag multiplier used in <calculate_hitlag>.
#macro hitlag_damage_multiplier				0.02 //{real} The hitlag damage multiplier used in <calculate_hitlag>.
#macro hitlag_time_max						120 //{int} The maximum number of frames of hitlag.
#macro hitlag_delay_animation				true //{bool} Whether to delay the hitlag animation for 1 frame or not.
#macro finishing_blow_hitlag_increase		40 //{int} The number of extra frames of hitlag a finishing blow causes.
#macro reeling_speed_threshold				12 //{int} The speed a player must be launched at for them to count as "reeling".
#macro balloon_speed_threshold				12 //{int} The speed a player must be launched at for balloon knockback to take effect.
#macro balloon_lower_frame					4 //{int} The number of frames at the start of hitstun in the balloon state that balloon knockback will take effect, regardless of speed.
#macro balloon_upper_frame					4 //{int} The number of frames at the end of hitstun in the balloon state that balloon knockback will NOT take effect, regardless of speed.
#macro balloon_end_speed_multiplier			0.75 //{int} The number the player's speed is multiplied by when the balloon state ends.
#macro crouch_cancel_armor					7.5 //{real} The maximum knockback that can be completely ignored by crouch canceling.
#macro autolink_speed_multiplier			3 //{real} The number the attacking player's speed is multiplied by when calculating the angle autolink hitboxes send at. A higher number will allow autolinks to be more consistent when players are moving quickly.
#macro magnetbox_snap_speed_default			10 //{real} The speed at which players are moved toward the magnet position after being hit by a magnetbox.
#macro hit_turnaround						true //{bool} Whether players turn to face the attacker when hit.
#macro damage_max							999 //{int} The maximum damage (or stamina) a player can have.
#macro damage_decimal_places				0 //{int} How many decimal places damage amounts will display. If this is set to 0, all damage amounts must be integers.
#macro combo_counter_break_frame			30 //{int} The number of frames the target has to be out of hitstun for the combo to automatically reset.
//Knockdown
#macro knockdown_slide_multiplier			0.75 //{real} This number is multiplied with the remaining hitstun of a player to determine how much landing lag they experience when hit into the ground. Only applies when the <knockdown_type> is KNOCKDOWN_TYPE.slide.
#macro knockdown_time_min					25 //{int} The minimum number of frames players are on the ground before being able to get up. Only applies when the <knockdown_type> is KNOCKDOWN_TYPE.normal.
#macro knockdown_time_max					300 //{int} The maximum number of frames players can be on the ground before automatically getting up with no invincibility.
#macro knockdown_lock_number				2 //{int} The maximum number of times you can lock someone in knockdown before they automatically get up. Only applies when the <knockdown_type> is KNOCKDOWN_TYPE.normal.
#macro knockdown_lock_time_min				40 //{int} The minimum number of frames players are on the ground before automatically getting up after being locked.
#macro getup_active_default					16 //{int} The default number of frames of invulnerability during a getup.
#macro getup_endlag_default					8 //{int} The default number of frames of lag after a getup.
//DI
#macro knockback_angle_default				90 //{real} The default knockback angle hitboxes use.
#macro asdi_default							4 //{real} The base distance players can move with ASDI.
#macro di_default							10 //{real} The maximum amount, in degrees, that players can change their knockback direction using DI.
#macro di_correction_max					23 //{real} The threshold, in degrees, that will allow the player to get the maximum DI in a direction. By default, this value is 23 to allow keyboard players to perfectly DI every move with only 8 directions.
#macro drift_di_accel						0.13 //{real} The speed at which players can accelerate with drift DI.
#macro drift_di_max							0.7 //{real} The maximum speed players can move at using drift DI.
#macro drift_di_lockout						4 //{int} The number of frames of hitstun before players can use drift DI.
//Angles
#macro s_angle_knockback_threshold			10 //{real} The minimum knockback before the sakurai angle flipper will switch to the "high" angle.
#macro s_angle_low_angle					0 //{real} The angle used for attacks under the knockback threshold with the sakurai angle flipper.
#macro s_angle_high_angle					40 //{real} The angle used for attacks over the knockback threshold with the sakurai angle flipper.
#macro s_angle_aerial_angle					45 //{real} The angled used for attacks hitting aerial opponents with the sakurai angle flipper.
//Jumping
#macro jumpsquat_allow_turnaround			false //{bool} Whether players can turn around at the end of jumpsquat or not.
#macro jumpsquat_change_momentum			true //{bool} Whether players can reverse their momentum at the end of jumpsquat or not.
#macro footstools_enable					true //{bool} Whether players can footstool other players by pressing jump when above them or not.
//Landing
#macro attack_landing_lag_default			5 //{int} The default landing lag of attacks.
#macro landing_buffer_jumpsquat				true //{bool} Whether players can start jumpsquat before landing lag finishes or not.
#macro helpless_fastfall_lag_increase		6 //{int} The number of extra frames of landing lag players experience if they fastfall during the helpless state.
//Smash Attacks
#macro smash_attack_charge_max				100 //{int} The maximum number of frames a smash attack can be charged for.
#macro smash_attack_multiplier				0.65 //{real} The maximum damage increase of a charged smash attack.
//Grabs
#macro grab_time_min						25 //{int} The minimum amount of time a grab can last.
#macro grab_time_multiplier					0.2 //{real} This number is multiplied with the grabbed player's damage to determine how many extra frames the grab can last.
#macro grab_snap_speed						30 //{real} The speed at which players are moved to the grab coordinates.
#macro grab_release_hsp						5 //{real} The horizontal speed players have when breaking out of a grab.
#macro grab_release_vsp						-8 //{real} The vertical speed players have when breaking out of a grab.
#macro grab_release_hitstun					20 //{int} The number of frames of hitstun players have when breaking out of a grab.
#macro grab_release_damage					3 //{int} The amount of damage both players take when a grab is broken.
#macro grab_regrab_time						65 //{int} The default number of frames after a grab or throw that players cannot be grabbed again.
#macro grab_with_shield_and_attack			false //{bool} Whether players can perform a grab by holding shield and pressing attack or not.
#macro grab_opponents_behind				false //{bool} Whether players can grab players that are behind their x origin or not.
#macro grab_opponents_behind_threshold		12 //{int} The horizontal distance behind an opponent where you can still grab them, if <grab_opponent_behind> is false.
#macro grab_break_enable					true //{bool} Whether players can break out of grabs by pressing the grab button in the first few frames.
#macro grab_break_window					2 //{int} How many frames at the start of being grabbed players have to perform a grab break. 
#macro grab_break_buffer_time				8 //{int} How many frames a grab break input lasts.
#macro grab_break_lockout_time				48 //{int} How many frames after a grab break input until the player can input another one.
#macro grab_break_command_grabs_default		false //{bool} Whether you can break command grabs by default or not. This can also be adjusted individually for command grabs.
#macro grab_break_hitlag					16 //{int} The number of hitlag frames both playerse experience during a grab break;
#macro grab_break_lag						25 //{int} The number of frames of lag both players experience after a grab break.
#macro grab_break_speed						8 //{real} The horizontal speed applied to both players in a grab break.
#macro grab_break_struggle_enable			true //{bool} Whether players enter a "grab struggle" state when trying to grab each other at the same time, instead of a triggering a grab break (overrides <grab_break_enable>).
#macro grab_break_struggle_time				60 //{int} How many frames a grab struggle lasts.
#macro grab_break_struggle_speed			14 //{real} The knockback the losing player is given after a grab struggle.
#macro grab_break_struggle_angle			60 //{real} The angle the losing player is launched after a grab struggle.
#macro grab_break_struggle_hitstun			30 //{int} The number of hitstun frames the losing player is given after a grab struggle.
#macro grab_break_struggle_damage			5 //{int} How much damage the losing player takes from a grab break struggle.
//Sound
#macro hit_sound_default					snd_hit_weak //{asset} The default sound played on hit.
#macro hit_sound_replace					false //{bool} Whether hit sounds will stop sounds of the same index that are currently being played or not.
#macro hit_sound_pitch_variance				0.2 //{real} The maximum amount of pitch shift a hit sound can have.
#macro hit_sound_priority_default			10 //{real} The priority of hit sounds. All stage music is played at a priority of 0 by default.
#macro hit_sound_replay_timer_default		3 //{int} The number of frames before a hit sound can be played again during local matches. Please note: In online matches, the <GGMR_PREDICTION_FRAMES_MAX> is used instead.
//Collisions
#macro platform_check_type					PLATFORM_CHECK_TYPE.precise //{int} The platform check type to use, from the enum PLATFORM_CHECK_TYPE.
#macro platform_snap_up_threshold			24 //{int} The number of pixels below a platform a player can be to still waveland on top of it.
#macro platform_snap_down_threshold			8 //{int} The number of pixels above a platform a player can be to still waveland on top of it.
#macro platform_drop_speed					1 //{real} The vertical speed players are given when dropping through a platform.
#macro solid_snap_threshold					12 //{int} The amount of pixels below a solid block a player can be to still waveland on top of it.
#macro bounce_minimum_speed					12 //{real} The speed players must have during hitstun to bounce off blocks and platforms.
#macro bounce_speed_multiplier				0.6 //{real} The speed multiplier used when players bounce.
#macro bounce_screen_shake_multiplier		0.3 //{real} The multiplier applied to the player's speed to determine how much the camera shakes when the player hits a wall without teching.
#macro slope_change_speed					true //{bool} Whether players will change speed when moving on slopes.
#macro slope_horizontal_pushes_down			false //{bool} Whether players will be moved down when moving horizontally into slopes that point downwards.
#macro jostle_type_default					JOSTLE_TYPE.gradual //{int} The jostle type to use, from the enum JOSTLE_TYPE.
#macro jostle_strength_default				1 //{real} The default strength of a jostle. Default for gradual: 1. Default for instant: 0.3.
#macro jostle_states						[PLAYER_STATE.idle, PLAYER_STATE.walking, PLAYER_STATE.walk_turnaround, PLAYER_STATE.crouching, PLAYER_STATE.run_stop, PLAYER_STATE.shielding, PLAYER_STATE.jumpsquat, PLAYER_STATE.shield_break] //{array} The player states that players can be jostled in. Default for instant: [PLAYER_STATE.idle, PLAYER_STATE.walking, PLAYER_STATE.walk_turnaround, PLAYER_STATE.crouching, PLAYER_STATE.run_stop, PLAYER_STATE.shielding, PLAYER_STATE.jumpsquat, PLAYER_STATE.running, PLAYER_STATE.run_turnaround, PLAYER_STATE.dashing, PLAYER_STATE.knockdown, PLAYER_STATE.parry_stun, PLAYER_STATE.parry_stun, PLAYER_STATE.shield_break, PLAYER_STATE.wavelanding].
#macro block_moving_recursion				1 //{int} The max amount moving blocks can recursively push away other collidable objects, and recursively pull collidable objects riding on top.
//Shielding
#macro shield_time_min						3 //{int} The minimum number of frames a player can shield for.
#macro shield_into_wavedash					true //{bool} Whether players can wavedash out of shield startup frames or not.
#macro shield_break_time_min				300 //{int} The minimum number of frames a players is stunned for after a shield break.
#macro shield_break_multiplier				0.2 //{real} This number is multiplied with the damage of the shield broken player to determine how many extra frames the stun can last.
#macro shieldstun_multiplier_default		0.9 //{real} The shieldstun multiplier, which determines how many frames a player is forced to continue shielding when hit by an attack.
#macro shieldstun_time_min					3 //{int} The minimum number of frames a player is foced to continue shielding when hit by an attack.
#macro shield_pushback_enable				true //{bool} Whether shielding players are pushed back by attacks or not.
#macro shield_pushback_multiplier			0.4 //{real} This number is multiplied with the damage of an attack to determine how much a player is pushed back for shielding the attack.
#macro shield_hitlag_multiplier				0.75 //{real} This number is multiplied with the base hitlag of an attack to determine how much hitlag players experience for shielding the attack.
#macro shield_hit_sound						snd_hit_weak2 //{asset} The sound played when an attack is shielded.
#macro shield_size_min						0.3 //{real} The minimum shield size.
#macro shield_size_multiplier_default		0.8 //{real} The default shield size multiplier for characters. Please note: If shield poking is disabled, the shield size is purely visual and has no impact on gameplay.
#macro powershield_reflect_multiplier		1.5 //{real} The speed multiplier for projectiles that are reflected with a powershield.
#macro shield_poking_enable					true //{bool} Whether shields create a separate hurtbox or not, which allows shield poking.
//Parrying Press
#macro parry_press_grabs					true //{bool} Whether you can parry grabs hitboxes or not.
#macro parry_press_stun_time_default		40 //{int} The base number of stun frames a parry causes.
#macro parry_press_hitlag					10 //{int} The number of hitlag frames a successful parry causes.
#macro parry_press_invincible_time			50 //{int} The number of frames of invincibility a successful parry rewards the player.
#macro parry_press_reflect_multiplier		1.5 //{real} The speed multiplier for projectiles that are reflected with a parry.
//Rolling
#macro roll_startup_default					3 //{int} The default number of frames it takes a roll to start.
#macro roll_active_default					14 //{int} The default number of frames a player is invulnerable and moving during a roll.
#macro roll_endlag_default					19 //{int} The default number of frames of lag after a roll.
//Teching
#macro tech_active_default					16 //{int} The default number of frames of invulnerability during a tech.
#macro tech_endlag_default					6 //{int} The default number of frames of lag after a tech.
#macro techroll_startup_default				8 //{int} The default number of frames before moving in a techroll.
#macro techroll_active_default				12 //{int} The default number of frames of moving during a techroll.
#macro techroll_endlag_default				16 //{int} The default number of frames of lag after a techroll.
//Reflectors
#macro reflector_speed_multiplier			1.25 //{real} The speed multiplier for projectiles that are reflected with a reflector hurtbox.
#macro reflector_damage_multiplier			1.5 //{real} The damage multiplier for projectiles that are reflected with a reflector hurtbox.
#macro reflector_lifetime_extension			30 //{int} The number of frames added on to a projectile's lifetime when reflected.
#macro reflector_damage_limit				50 //{int} The maximum damage reflectors can reflect. If the projectile's damage is over this amount, the projectile will simply pass through the reflector.
//Ledges
#macro ledge_grab_timeout_standard			70 //{int} The amount of time after letting go of a ledge that players cannot grab any ledge again.
#macro ledge_snap_speed						16 //{real} The speed at which players snap to the ledge.
#macro ledge_grab_distance					26 //{real} The distance players can start to snap to a ledge from.
#macro ledge_snap_time						3 //{int} The number of frames it takes for a player to snap to the ledge.
#macro ledge_hang_time_min					10 //{int} The minimum number of frames a player has to hang on the ledge for before choosing a ledge option.
#macro ledge_hang_time_max					180 //{int} The maximum number of frames a player can hang on the ledge for before automatically letting go.
#macro ledge_invincible_time				15 //{int} The number of frames of invincibility a player gets when grabbing onto the ledge. Certain ledge options may override this invincibility.
#macro ledge_grab_max						3 //{int} The maximum number of times players can grab the ledge before touching the ground again. Set it to -1 to have no limit.
#macro ledge_grab_invincible_limit			1 //{int} The number of times players can grab the ledge before they won't get invincibility.
#macro ledge_tether_snap_speed				18 //{real} The speed at which players tether to the ledge.
#macro ledge_tether_snap_accel				3 //{real} The acceleration players have when tethering to the ledge.
#macro ledge_tether_hang_time				120 //{int} The maximum number of frames you can hang during a tether before automatically snapping to the ledge.
#macro ledge_tether_snap_time				22 //{int} The number of frames it takes for a player to snap to the ledge during a tether.
#macro ledge_tether_jump_hsp				4 //{real} The horizontal speed of the player when jump canceling a tether.
#macro ledge_tether_jump_vsp				-9 //{real} The vertical speed of the player when jump canceling a tether.
#macro ledge_trump_stun_time				25 //{int} The number of frames a player is stunned after being kicked off a ledge.
#macro ledge_trump_hsp						-6 //{real} The horizontal speed players have when being kicked off a ledge.
#macro ledge_trump_vsp						-11 //{real} The vertical speed players have when being kicked off a ledge.
#macro ledge_getup_check_collision			false //{bool} Whether players cannot perform a ledge getup into a solid block or slope.

#macro ledge_jump_time_default				12 //{int} The default number of frames to start a ledge jump.
#macro ledge_getup_time_default				23 //{int} The default number of frames to get up from the ledge.
#macro ledge_roll_time_default				12 //{int] The default number of frames to start a ledge roll.
#macro ledge_attack_time_default			12 //{int] The default number of frames to start a ledge attack.
//Wall Jumps
#macro wall_cling_time_max					60 //{int} The maximum number of frames a player can cling to the wall.
#macro wall_cling_normal_timeout			120 //{int} The number of frames after clinging to a wall that players cannot cling to the wall again.
#macro wall_jump_normal_timeout				15 //{int} The number of frames after wall jumping that players cannot wall jump again.
#macro wall_jump_check_distance				1 //{int} The amount of pixels to the left or right players check for walls when trying to wall jump.
#macro wall_jump_check_distance_slope_x		5 //{int} The amount of pixels to the left or right players check for walls when trying to wall jump off a slope.
#macro wall_jump_check_distance_slope_y		-5 //{int} The amount of pixels to the up or down players check for walls when trying to wall jump off a slope.
#macro wall_jump_check_slope_angle			45 //{int} The maximum angle difference from 270 degrees of slopes players can wall jump off.
#macro wall_cling_check_distance			1 //{int} The amount of pixels to the left or right players check for walls when trying to wall cling.
//Airdodges
#macro airdodge_adjust_endlag				true //{bool} Whether the "accelerate" type airdodge should scale endlag based on the direction or not.
#macro airdodge_adjust_speed				true //{bool} Whether the "accelerate" type airdodge should scale speed based on the direction or not.
#macro airdodge_direction_limit				-1 //{int} The number of directions players can airdodge in. Set to -1 for no limit on the direction.
#macro airdodge_restore_in_hitlag			false //{bool} Whether the player's airdodges are restored when they are in hitlag or not.
#macro airdodge_allow_ledge_grab			true //{bool} Whether players can grab ledges during the endlag of an airdodge or not.
#macro airdodge_from_jumpsquat				true //{bool} Whether players can airdodge out of jumpsquat. Please note: This only applies to AIRDODGE_TYPE.momentum_stop.
#macro airdodge_upward_from_jumpsquat		false //{bool} Whether players can airdodge upwards out of jumpsquat. This only works if <airdodge_from_jumpsquat> is also true. Please note: This only applies to AIRDODGE_TYPE.momentum_stop.
//Wavedashing
#macro wavedash_horizontal_assist			true //{bool} Whether to make it easier to wavedash horizontally or not.
#macro wavedash_horizontal_threshold		10 //{real} The maximum degrees away from a perfectly horizontal wavedash that will be corrected.
#macro waveland_time_min					4 //{int} The minimum number of frames before a player can cancel a waveland/wavedash with another action.
//Moonwalking
#macro moonwalk_enable						true //{bool} Whether moonwalking is enabled or not.
#macro moonwalk_time						25 //{int} The minimum number of frames a moonwalk can last.
//Knockouts
#macro ko_time_min							60 //{int} The number of frames a player is knocked out before respawning.
#macro ko_distance_scaling					0.15 //{real} The scaling applied to the KO time based on how far away the attacker is from the middle of the stage. Set this to 0 for no distance scaling.
#macro ko_time_max							160 //{int} The maximum number of frames a player can be knocked out for. This is only used if <ko_distance_scaling> is not 0.
#macro star_ko_time							180 //{int} The number of frames the star KO animation takes.
#macro star_ko_chance						5 //{int} Players KOed off the top on a frame number divisible by this number will be star KOed.
#macro star_ko_distance						(room_height div 2) //{real} The distance players fall during the star KO animation.
#macro screen_ko_time						100 //{int} The number of frames the screen KO animation takes.
#macro screen_ko_chance						6 //{int} Players KOed off the top on a frame number divisible by this number will be screen KOed.
#macro screen_ko_scale_multiplier			3 //{real} The sprite scale used for players being screen KOed.
#macro respawn_platform_time_max			180 //{int} The maximum amount of time players can stay on the respawn platform.
#macro respawn_inv_time						90 //{int} The number of frames of invincibility players get after leaving the respawn platform.
#macro respawn_inv_end_on_attack			true //{bool} Whether respawn invincibility goes away after a player attacks or not.
#macro respawn_platform_change_facing		true //{bool} Whether players can change the direction they are facing when leaving the platform or not.
#macro respawn_platform_taunt_enable		true //{bool} Whether players can taunt on the respawn platform or not.
#macro share_stock_enable					true //{bool} Whether players can share stocks when <match_team_mode> is turned on.
//Screen wrap
#macro screen_wrap_damage					15 //{int} The amount of damage players take when wrapping the screen.
//EX Moves
#macro ex_meter_max							1000 //{real} The maximum value of the EX meter by default.
#macro ex_meter_split						3 //{int} The number of sections in the EX meter by default.
//Hitbox Drawing
#macro melee_draw_color						c_red //{color} The color for melee hitboxes.
#macro magnetbox_draw_color					c_blue //{color} The color for magnetboxes.
#macro projectile_draw_color				c_yellow //{color} The color for projectiles.
#macro grab_draw_color						c_blue //{color} The color for grab hitboxes.
#macro windbox_draw_color					c_teal //{color} The color for windboxes.
#macro detectbox_draw_color					c_purple //{color} The color for detectboxes.
#macro hitbox_draw_angle_multiplier			8 //{real} This number is multiplied by the hitbox's base knockback to determine how long the debug launch arrow will be drawn.
#macro hurtbox_draw_color					c_lime //{color} The color for hurtboxes.
#macro collision_box_draw_color				c_white //{color} The color for collision boxes.
//Animation
#macro anim_speed_normal					0.3 //{real} The default speed for animations. Every frame, the image index will increase by this number.
#macro anim_state_normal					"Idle" //{string} The state to use the animation value of when <anim_reset> is called.
#macro anim_frame_normal					0 //{real} The frame in the sprite animations start on by default.
#macro anim_angle_normal					0 //{real} The angle animations use by default.
#macro anim_alpha_normal					1.0 //{real} The alpha animations use by default. Alpha is a number from 0 to 1.
#macro anim_scale_normal					1 //{real} The sprite scale animations use by default.
#macro anim_offset_normal					0 //{int} The default value used for the x and y offset of animations.
#macro anim_loop_normal						true //{bool} Whether animations should loop by default or not.
#macro anim_finish_normal					-1 //{int} DO NOT CHANGE. By default, animations have no finish animation.
//Aerial State
#macro aerial_state_use_momentum_drift		false //{bool} Whether the aerial state uses momentum based drift or clamped speed drift. Momentum based drift allows players to go over the max drift speed from external forces such as windboxes
#macro aerial_restrict_speed_instantly		false //{bool} Whether the aerial state instantly clamps the speed when switched to.
//Items
#macro item_spawn_interval					120 //{int} The number of frames that must pass before the game tries to spawn another item.
#macro item_limit							5 //{int} The maximum number of items that can be in the game before random spawning will turn off.
#macro item_sprite_scale_default			2 //{real} The default sprite scale used for all items.
//CSS
#macro css_character_sprite_scale			1 //{int} The scaling of the sprite used for characters on the CSS.
#macro css_cursor_loop_time					20 //{int} The number of frames before a player's cursor can will loop around the CSS.
//Win Screen
#macro win_screen_winner_render_scale		2 //{int} The scaling of the winner's render sprite on the Win Screen.
#macro win_screen_losers_portrait_scale		2 //{int} The scaling of the losers' portrait sprites on the Win Screen.
//Online
//Replays
#macro replay_sync_mode						true //{bool} Whether to save extra data in replays to catch desyncs or not. This will greatly increase the file size of replays.
//Clips
#macro clip_length							180 //{int} The number of previous frames that are saved in a clip. Clips are saved at 30fps.
#macro clip_quality							1 //{int} The quality of GIF to export for clips. This is a number from 0-3.
#macro clip_save_interval					2 //{int} The interval between frames that are saved in a clip. By default this number is 2, because clips are saved at 30fps.
#endregion
/* Copyright 2023 Springroll Games / Yosi */