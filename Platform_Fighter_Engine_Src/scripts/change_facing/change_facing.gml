///@category Player Actions
///@param {int} [stick]			Either <Lstick> or <Rstick>
///@param {int} [frame]			The frame to check to change the facing direction
/*
Checks the value of the given control stick, and changes the player's facing direction accordingly.
If the control stick was not tilted on the given frame, the facing direction will not be changed.
*/
function change_facing() {
	//Change the facing based on the control stick.
	//If it is neutral, there is no change.
	var _stick = argument_count > 0 ? argument[0] : Lstick;
	var _frame = argument_count > 1 ? argument[1] : 0;
	if (stick_check(_stick, true, false, DIR.right, undefined, undefined, _frame, true))
		{
		facing = 1;
		}
	else if (stick_check(_stick, true, false, DIR.left, undefined, undefined, _frame, true))
		{
		facing = -1;
		}  
}
/* Copyright 2023 Springroll Games / Yosi */