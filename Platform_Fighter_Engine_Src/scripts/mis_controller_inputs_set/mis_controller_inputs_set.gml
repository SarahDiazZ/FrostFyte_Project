///@category Menu Input System
//@param {int/array} confirm			The button(s) to set for the confirm input
//@param {int/array} back				The button(s) to set for the back input
//@param {int/array} option				The button(s) to set for the option input
//@param {int/array} remove				The button(s) to set for the remove input
//@param {int/array} page_next			The button(s) to set for the page next input
//@param {int/array} page_last			The button(s) to set for the page last input
//@param {int/array} start				The button(s) to set for the start input
//@param {int/array} select				The button(s) to set for the select input
/*
Set what buttons on the controller are used for each input for the Menu Input System. You can set an array of multiple buttons for each input.
*/
function mis_controller_inputs_set() {
	mis_data().controller_inputs = 
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