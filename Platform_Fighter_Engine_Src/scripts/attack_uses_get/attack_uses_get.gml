///@category Attacking
///@param {asset} [attack_script]		The attack to get the number of uses of
/*
Returns how many times an attack can be used.
All attacks will have undefined (infinite) uses by default.
*/
function attack_uses_get() {
	var _uses = undefined;
	var _script = (argument_count > 1 && script_exists(argument[1])) ? argument[1] : attack_script;

	if (_script != -1)
		{
		_uses = attack_uses[$ string(_script)];
		}
		
	return _uses;
}
/* Copyright 2023 Springroll Games / Yosi */