///@category Command Line Interface
///@param {struct} CLI      The CLI struct
/*
Executes the command currently typed on the command line.
Returns true or false depending on if the command was valid or not.
*/
function cli_execute() {
    var _cli = argument[0];
    assert(is_struct(_cli), "[cli_execute] The given CLI was not a struct");
    var _text = _cli.text;
    
    //Find the command
    var _tokens = [];
    var _pos = 1;
    while(true)
        {
        var _index = string_pos_ext(" ", _text, _pos);
        if (_index != 0)
            {
            array_push(_tokens, string_copy(_text, _pos, _index - _pos));
            _pos = _index + 1;
            }
        else
            {
            array_push(_tokens, string_copy(_text, _pos, string_length(_text) - _pos + 1));
            break;
            }
        }
    var _num_tokens = array_length(_tokens);
    
    //If no command is given
    if (_num_tokens <= 0) then return false;
    
    for(var i = 0; i < _cli.length; i++)
        {
        if (_cli.list[@ i][@ 0] == _tokens[@ 0])
            {
            //Check number of arguments
            if (array_length(_cli.list[@ i][@ 1]) == (_num_tokens - 1))
                {
                try
                	{
					if (is_method(_cli.list[@ i][@ 2]))
						{
						_cli.list[@ i][@ 2](_tokens);
						}
					else
						{
						script_execute(_cli.list[@ i][@ 2], _tokens);
						}
                	}
                catch (_e)
                	{
                	log("[cli_execute] An error was caught: ", _e);
                	}
                return true;
                }
            }
        }
        
    return false;
}
/* Copyright 2023 Springroll Games / Yosi */