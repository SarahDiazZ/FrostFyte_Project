///@category Menu Input System
//@param {int/array} confirm			The key(s) to set for the confirm input
//@param {int/array} back				The key(s) to set for the back input
//@param {int/array} option				The key(s) to set for the option input
//@param {int/array} remove				The key(s) to set for the remove input
//@param {int/array} page_next			The key(s) to set for the page next input
//@param {int/array} page_last			The key(s) to set for the page last input
//@param {int/array} start				The key(s) to set for the start input
//@param {int/array} select				The key(s) to set for the select input
/*
Set what keys on the keyboard are used for each input. You can set an array of multiple keys for each input.
*/
function mis_keyboard_inputs_set() {
	mis_data().keyboard_inputs = 
		[
		argument[0],
		argument[1],
		argument[2],
		argument[3],
		argument[4],
		argument[5],
		argument[6],
		argument[7],
		];
	return;
}
/* Copyright 2023 Springroll Games / Yosi */