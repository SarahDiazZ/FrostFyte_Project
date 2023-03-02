///@category Menus
/*
This object displays the String Inputter. There can only be one instance at a time.
The string inputter allows players to create strings with controller input, or by typing on the keyboard.
You can use the function <string_inputter_get_string> to create an instance, and <string_inputter_is_open> to check if one already exists.
*/
///@description
inputter_letters = valid_string_characters;
inputter_letter_count = array_length(inputter_letters);
inputter_prompt = "Please enter a string:";
inputter_string = "Default";
inputter_max_length = 12;
inputter_current = 0;
inputter_default = "Default";
inputter_callback = undefined;
inputter_custom = undefined;
inputter_row_length = 10;
inputter_hidden = false;

//Menu input system
mis_init();

//Keyboard backspace repeat
inputter_backspace_held_time = 0;
/* Copyright 2023 Springroll Games / Yosi */