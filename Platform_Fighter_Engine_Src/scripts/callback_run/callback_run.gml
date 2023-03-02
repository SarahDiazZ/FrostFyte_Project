///@param {array} callback			The callback array to run
///@param {any} [argument]			The argument to run the script with
/*
Runs all scripts stored in the given callback array.
You can optionally pass an argument that will be passed to the script as the first argument.
The second argument passed to the script will be the id of the calling instance.
Scripts will be run on whatever target id is stored.
Any scripts with the type "CALLBACK_TYPE.one_time" will be removed from the array immediately after being run.
*/
function callback_run() {
	var _cb = argument[0];
	var _arg = argument_count > 1 ? argument[1] : undefined;
	for(var i = 0; i < array_length(_cb); i += CALLBACK_SCRIPT.LENGTH)
		{
		//Extract
		var _script = _cb[@ i + CALLBACK_SCRIPT.script];
		var _type = _cb[@ i + CALLBACK_SCRIPT.type];
		var _target = _cb[@ i + CALLBACK_SCRIPT.target];
		
		//Run
		if (_target != id)
			{
			with(_target)
				{
				script_execute(_script, _arg, other.id);
				}
			}
		else
			{
			script_execute(_script, _arg, id);
			}
			
		//One-time scripts
		if (_type == CALLBACK_TYPE.one_time)
			{
			array_delete(_cb, i, CALLBACK_SCRIPT.LENGTH);
			i -= CALLBACK_SCRIPT.LENGTH;
			}
		}
	return _cb;
}
/* Copyright 2023 Springroll Games / Yosi */