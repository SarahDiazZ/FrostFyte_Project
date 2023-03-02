///@category Menu Input System
///@param {int} device_id				The id of the device
///@param {int} [interval]				How many frames are between each repeated "press"
///@param {int} [initial_wait]			The number of frames that must pass before repeated presses start
/*
Returns a struct with x and y boolean properties that tell if the stick was pressed or held for a certain interval in that direction.
This is to recreate how keyboards normally work - holding a key for a certain amount of time will count as repeatedly pressing that key.
*/
function mis_device_stick_press_repeated() {
	var _id = argument[0];
	var _interval = argument_count > 1 ? argument[1] : 6;
	var _initial_wait = argument_count > 2 ? argument[2] : 10;
	//Find the device with the given id number
	var _array = mis_data().devices;
	for(var i = 0; i < array_length(_array); i++) 
		{
		if (_array[@ i][@ MIS_DEVICE_PROPERTY.device_id] == _id) 
			{
			var _stick_values = _array[@ i][@ MIS_DEVICE_PROPERTY.stick_values];
			var _struct = { x : false, y : false };
			if (_stick_values.press || (_stick_values.hold > _initial_wait && (_stick_values.hold % _interval == 0))) 
				{
				if (abs(_stick_values.x) > abs(_stick_values.y)) 
					{
					_struct.x = true;
					} 
				else
					{
					_struct.y = true;
					}
				}
			return _struct;
			}
		}
	crash("[mis_device_stick_press_repeated] No device exists with the given ID (", _id, ")");
}
/* Copyright 2023 Springroll Games / Yosi */