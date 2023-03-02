///@category Attacking
///@param {string} name					The name of the simple attack
///@param {struct} attack_struct		The data for the simple attack
///@param {bool} [predefined]			Whether the attack should always be in memory or not
/*
Allows you to define a simple attack, and returns the name of the attack, which can be used to access the data later.
The <simple_attack_runner> script is used to handle simple attacks during gameplay.
If the "predefined" argument is true, the attack will always stay in memory; otherwise, it will get deleted after the match.

Simple Attacks can have the following properties:
	- windows {array} : Required. All of the windows in the attack. There must be at least 1 window. They will be played in order.
	- sprite {asset} : Required. The sprite set at the start of the attack.
	- preset {int} : Any preset to use for the attack. From the SIMPLE_ATTACK_PRESET enum.
	- type {"both"|"ground"|"air"} : What cancels the attack has.
	- movement {"all"|"ground"|"hit_platforms"|"through_platforms"} : What type of movement to be used.
	- hurtbox {asset} : A sprite to use for the hurtbox.
	- state_end {int} : The state the attack ends on.
	- vars {struct} : Sets all of the instance variables in the struct when the attack is first run.

The format for "windows" in the array:
	- length {int} : Required. The number of frames the window lasts. Must be greater than 0. If this is the last window in the array, the attack ends afterwards.
	- whiff_lag {int} : The extra number of frames added to the window at the start if the attack has not hit.
	- charge {int} : The number of frames the window can be charged.
	- anim_start {int} : The animation frame to start on. If not given, the attack won't change from the current frame.
	- anim_end {int} : The animation frame to end on. Must be used in conjunction with "anim_start".
	- vars {struct} : Sets all of the instance variables in the struct every frame.
	- speed {array} : Speed to set at the start of the window. Format is [hsp, vsp, hrel, vrel]. Hsp is in the direction the player is facing.
	- hitboxes {array} : An array of structs. All of the hitboxes in this array will be created during the window.
	- reset_hitbox_groups {bool} : Whether to reset hitbox groups at the start of the window or not.
	- throw_position {array} : The x and y to hold a grabbed opponent at during a throw. Format is [x, y]. Only works for the preset SIMPLE_ATTACK_PRESET.a_throw.

The format for "hitbox" structs:
	- type {"melee"|"projectile"|"windbox"|"magnetbox"|"grab"|"pummel"|"throw"|"smash"} : Required. The hitbox object to create. Doesn't support detectboxes.
	- args {array} : Required. The arguments for the specific hitbox create script, in order.
	- frame {int} : The frame of the window the hitbox is created on.
	- vars {struct} : Sets all of the instance variables for the hitbox after creation.
	- anim_frame : The frame to set for the player when the hitbox is created.
	- overlay_sprite : The overlay sprite to assign to the hitbox.
*/
function simple_attack_define() {
	var _name = argument[0];
	var _struct = argument[1];
	var _predefined = argument_count > 2 ? argument[2] : false;
	var _data = simple_attack_data();
	
	//If the attack already exists
	if (variable_struct_exists(_data, _name))
		{
		log("[simple_attack_define] The attack named ", _name, " has already been defined");
		}
	else
		{
		_struct[$ "predefined"] = _predefined;
		_data[$ _name] = _struct;
		}
	
	return _name;
}
/* Copyright 2023 Springroll Games / Yosi */