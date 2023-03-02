///@category Command Line Interface
///@param {struct} CLI      The CLI struct
/*
Returns an array of all commands (arrays) that could be completed from the current text on the command line.
*/
function cli_autocomplete() {
    var _cli = argument[0];
    assert(is_struct(_cli), "[cli_execute] The given CLI was not a struct");
    var _text = _cli.text;
    
    //Find the command
    var _commands_left = [];
    for(var i = 0; i < _cli.length; i++)
        {
        array_push(_commands_left, _cli.list[@ i]);
        }
    var _size = string_length(_text);
    for(var i = 1; i <= _size; i++)
        {
        var _char = string_char_at(_text, i);
        for(var m = array_length(_commands_left) - 1; m >= 0; m--)
            {
			var _command_char = string_char_at(_commands_left[@ m][@ 0], i);
            if (_command_char != _char && (_command_char != "" || _char != " "))
                {
                array_delete(_commands_left, m, 1);
                }
            }
		if (_char == " ") then break;
        }
        
    return _commands_left;
}
/* Copyright 2023 Springroll Games / Yosi */