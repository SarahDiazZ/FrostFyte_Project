///@category Menu Input System
///@param {int} right		The key(s) to set for moving the stick right
///@param {int} left		The key(s) to set for moving the stick left
///@param {int} up			The key(s) to set for moving the stick up
///@param {int} down		The key(s) to set for moving the stick down
/*
Set the keys to be used for the control stick in menus.
*/
function mis_keyboard_stick_set() {
	mis_data().keyboard_stick = [argument[0], argument[1], argument[2], argument[3]];
	return;
}
/* Copyright 2023 Springroll Games / Yosi */