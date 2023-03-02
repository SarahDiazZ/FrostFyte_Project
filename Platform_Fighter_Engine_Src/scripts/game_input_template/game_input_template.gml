///@category Gameplay
/*
The template that will be used to create all player input buffers.
Returns a new "blank" input buffer.
*/
function game_input_template() {
	var _b = buffer_create(input_buffer_size, buffer_fixed, 1);
	
	//Empty input bitlag
	buffer_write(_b, buffer_u32, 0);
	
	//Control stick data
	buffer_write(_b, buffer_s8, 0);
	buffer_write(_b, buffer_s8, 0);
	buffer_write(_b, buffer_s8, 0);
	buffer_write(_b, buffer_s8, 0);
	return _b;
}
/* Copyright 2023 Springroll Games / Yosi */