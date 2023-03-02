///@category Command Line Interface
///@param {array} command_list					An array of commands in the specified format
/*
Creates and returns a command line struct that can be used for other command line functions.
The command list array should contain arrays of the following format for each command:
    - [function_name, [parameters...], script/method, color]
*/
function cli_init() {
    var _list = argument[0];
    assert(is_array(_list), "[cli_init] The given command list is not an array");
    var _cli = {};
    _cli.list = _list;
    _cli.length = array_length(_list);
    _cli.text = "";
    return _cli;
}
/* Copyright 2023 Springroll Games / Yosi */