///@category Control Stick
///@param {int}	input		The input to check for from the INPUT enum
/*
Returns <Rstick> if the right stick is set to the specified input and has been flicked.
Otherwise, it returns <Lstick>.
This is used for choosing which stick to use for attack directions.
*/
function stick_choose_by_input() {
	var _default = Lstick;
	var _override = Rstick;

	//Check the right stick iput
	if (right_stick_input == argument[0])
		{
		if (stick_flicked(_override, DIR.any, buffer_time_standard, false))
			{
			return _override;
			}
		}
	return _default;
}
/* Copyright 2023 Springroll Games / Yosi */