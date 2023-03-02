///@category Command Line Interface
///@param {struct} CLI      The CLI struct
///@param {string} text     The text to set
/*
Sets the current text for the command line.
*/
function cli_text_set() {
    var _cli = argument[0];
    _cli.text = argument[1];
}
/* Copyright 2023 Springroll Games / Yosi */