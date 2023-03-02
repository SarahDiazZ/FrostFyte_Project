///@category Player Actions
///@param {int} state		The state, from the PLAYER_STATE enum
/*
Sets the state of the calling player.

This will:
	- Reset the player's "state_" variables
	- Reset the player's animation
	- Reset the player's permanent hurtbox
	- Reset the player's collision box
	- Reset the player's renderer
	
Depending on the state, additional actions may happen.
*/
function state_set() {
	//Run the Stop Phase of the current state
	if (script_exists(state_script))
		{
		script_execute(state_script, PLAYER_STATE_PHASE.stop, argument[0]);
		}

	//Change the state
	state = argument[0];
	state_time = 0;
	state_frame = 0;
	state_phase = 0;
	state_facing = 1;
	state_script = my_states[@ state];
	
	//Reset callbacks
	callback_clean(callback_passive);
	callback_clean(callback_hud);
	callback_clean(callback_overhead);
	callback_clean(callback_draw_begin);
	callback_clean(callback_draw_end);
	callback_clean(callback_hit);
	callback_clean(callback_hurt);
	
	//Item holding
	item_hold_x = item_hold_x_default;
	item_hold_y = item_hold_y_default;
	
	/* DEBUG */
	if (setting().debug_mode_enable)
		{
		//Add states
		if (state_log[@ player_state_log_size - 1] != state)
			{
			array_push(state_log, state);
			array_delete(state_log, 0, 1);
			}
		}

	//Reset the hurtbox
	hurtbox_reset();

	//Reset the collision box
	if (on_ground())
		{
		collision_box_change(collision_box, "bottom");
		}
	else
		{
		collision_box_change();
		}

	//Reset the player renderer (layer)
	player_renderer_set(obj_player_renderer);
	
	//Held items are visible by default
	item_visible = true;
	
	//Blastzones
	ignore_blastzones = false;

	//Run the Start Phase of the new state
	script_execute(state_script, PLAYER_STATE_PHASE.start);
}
/* Copyright 2023 Springroll Games / Yosi */