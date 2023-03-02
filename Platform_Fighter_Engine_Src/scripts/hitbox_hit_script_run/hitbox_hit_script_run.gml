///@category Hitboxes
///@param {asset} script		The script to run
///@param {id} hurtbox			The hurtbox being hit
/*
Runs a hitbox on-hit script for the calling hitbox.
*/
function hitbox_hit_script_run() {
	var _script = argument[0];
	var _hurtbox = argument[1];
	if (_script != -1 && script_exists(_script))
		{
		with(owner)
			{
			script_execute(_script, other.id, _hurtbox);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */