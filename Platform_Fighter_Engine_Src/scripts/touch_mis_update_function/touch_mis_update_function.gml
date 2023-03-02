///@category Touch Controls
///@param {array} device			The device array 
/*
The function passed to the MIS to connect it with the touch controls.
*/
function touch_mis_update_function() {
	var _device = argument[0];
	var _type = _device[@ MIS_DEVICE_PROPERTY.device_type];
	var _inputs = _device[@ MIS_DEVICE_PROPERTY.inputs];
	var _stick = _device[@ MIS_DEVICE_PROPERTY.stick_values];
				
	//Safety check
	if (_type != MIS_DEVICE_TYPE.custom) then return;
			
	//Control stick
	_stick.x = clamp(obj_touch_stick.stick_x, -1, 1);
	_stick.y = clamp(obj_touch_stick.stick_y, -1, 1);
	var _len = point_distance(0, 0, _stick.x, _stick.y);
	if (_len > mis_data().controller_deadzone) 
		{
		_stick.hold += 1;
		if (_stick.hold == 1) 
			{
			_stick.press = true;
			} 
		else 
			{
			_stick.press = false;
			}
		} 
	else 
		{
		_stick.press = false;
		_stick.hold = 0;
		}
				
	//Buttons
	with(obj_touch_button)
		{
		_inputs[@ input_menu] = pressed;
		_inputs[@ input_menu + MIS_INPUT.LENGTH] = held_time;
		}
}
/* Copyright 2023 Springroll Games / Yosi */