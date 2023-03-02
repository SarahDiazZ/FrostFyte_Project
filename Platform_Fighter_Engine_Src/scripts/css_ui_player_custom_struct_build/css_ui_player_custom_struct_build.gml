///@param device_id
///@param cursor_index
///@param group_number
///@param token_held
///@param token_x
///@param token_y
///@param cursor_active
function css_ui_player_custom_struct_build() {
	return 				
		{
		device_id : argument[0], 
		cursor : argument[1], 
		group : argument[2], 
		token_held : argument[3], 
		token : { x : argument[4], y : argument[5] },
		cursor_active : argument[6],
		cursor_loop_frame : 0,
		};
}
/* Copyright 2023 Springroll Games / Yosi */