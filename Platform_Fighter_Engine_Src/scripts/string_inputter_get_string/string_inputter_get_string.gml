///@category Menus
///@param {string} prompt			The message prompt to display
///@param {string} default			The default string
///@param {function} callback		The function to run when the player has finished inputting the string
///@param {any} [custom]			Any value that will be passed into the callback function as the second argument
///@param {int} [max_length]		The maximum length of the string
///@param {array} [valid]			An array of single character strings that will appear on the inputter
///@param {int} [row_length]		How many characters will be drawn on each row
/*
Creates the <obj_string_inputter> and initializes it based on the given arguments.
The instance id of the inputter is returned.
The callback function takes two arguments:
	- {string} string		The string returned from the inputter
	- {any} [custom]		Any custom value that was passed to the function
*/
function string_inputter_get_string() {
	assert(!string_inputter_is_open(), "[string_inputter_get_string] You cannot create obj_string_inputter when there is already an instance in the room!");
	var _id = instance_create_layer(0, 0, layer, obj_string_inputter);
	with(_id)
		{
		inputter_prompt = argument[0];
		inputter_string = "";
		inputter_default = argument[1];
		inputter_callback = argument[2];
		inputter_custom = argument_count > 3 ? argument[3] : undefined;
		inputter_max_length = argument_count > 4 ? argument[4] : 12;
		inputter_letters = argument_count > 5 ? argument[5] : valid_string_characters;
		inputter_letter_count = array_length(inputter_letters);
		inputter_row_length = argument_count > 6 ? argument[6] : 10;
		}
	return _id;
}
/* Copyright 2023 Springroll Games / Yosi */