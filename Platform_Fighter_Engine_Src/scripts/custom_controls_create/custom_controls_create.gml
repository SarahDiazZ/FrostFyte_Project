///@category Custom Controls
///@param {bool} [clear]		Whether to return a completely blank custom controls struct or not
/*
Creates and returns a new custom controls struct with the default controls.
If clear is true, it will return a struct with no custom controls set at all.
*/
function custom_controls_create() {
	var _struct = {};

	var _inputs_controller = [];
	var _inputs_keyboard = [];
	var _inputs_touch = [];

	//Possible Inputs & Buttons / Keys
	for(var i = 0; i < CC_INPUT_CONTROLLER.LENGTH; i++)
		{
		var _possible_buttons = [];
		array_push(_inputs_controller, _possible_buttons);
		}
	for(var i = 0; i < CC_INPUT_KEYBOARD.LENGTH; i++)
		{
		var _possible_keys = [];
		array_push(_inputs_keyboard, _possible_keys);
		}
	for(var i = 0; i < CC_INPUT_TOUCH.LENGTH; i++)
		{
		var _possible_keys = [];
		array_push(_inputs_touch, _possible_keys);
		}
		
	_struct.inputs_controller = _inputs_controller;
	_struct.inputs_keyboard = _inputs_keyboard;
	_struct.inputs_touch = _inputs_touch;
	
	//Right stick input
	_struct.right_stick_input = INPUT.smash;

	//SCS
	_struct.scs = array_create(SCS.LENGTH, false);
	
	//ACS
	_struct.acs = array_create(ACS.LENGTH, false);

	//Default
	var _clear = argument_count > 0 ? argument[0] : false;
	if (!_clear)
		{
		custom_controls_default(_struct);
		}

	return _struct;
}
/* Copyright 2023 Springroll Games / Yosi */