///@category Menu Input System
///@param {int} device_id				The id of the device
///@param {int} input					The input to check, from the MIS_INPUT enum
///@param {int} [interval]				How many frames are between each repeated "press"
///@param {int} [initial_wait]			The number of frames that must pass before repeated presses start
/*
Returns true if the input is pressed in the Menu Input System, or on an interval after the input has been held for enough time.
This is to recreate how keyboards normally work - holding a key for a certain amount of time will count as repeatedly pressing that key.
*/
function mis_device_input_repeated() {
	var _id = argument[0];
	var _input = argument[1];
	var _interval = argument_count > 2 ? argument[2] : 6;
	var _initial_wait = argument_count > 3 ? argument[3] : 10;
	//Find the device with the given id number
	var _array = mis_data().devices;
	for(var i = 0; i < array_length(_array); i++) 
		{
		if (_array[@ i][@ MIS_DEVICE_PROPERTY.device_id] == _id) 
			{
			if (_array[@ i][@ MIS_DEVICE_PROPERTY.inputs][@ _input]) 
				{
				return true;
				} 
			else 
				{
				var _held_time = _array[@ i][@ MIS_DEVICE_PROPERTY.inputs][@ _input + MIS_INPUT.LENGTH];
				if (_held_time > _initial_wait && (_held_time % _interval == 0)) 
					{
					return true;
					}
				}
			return false;
			}
		}
	crash("[mis_device_input_repeated] No device exists with the given ID (", _id, ")");
}
/* Copyright 2023 Springroll Games / Yosi */