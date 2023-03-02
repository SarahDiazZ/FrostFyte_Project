///@param {real} current		The starting amount
///@param {real} target			The goal amount
///@param {real} amount			The maximum amount the current can move towards the goal
/*
Adds or subtracts the "amount" from the "current" to get it closer to the "target".
The returned value cannot overshoot the target.
*/
function approach() {
	var c = argument[0];
	var t = argument[1];
	var a = argument[2];
	if (c < t)
		{
	    c = min(c + a, t); 
		}
	else
		{
	    c = max(c - a, t);
		}
	return c;
}

/* Copyright 2023 Springroll Games / Yosi */