///@category Inputs
///@param {int} input		The input to press, from the INPUT enum
/*
To be used in <cpu_script_base> or character-specific CPU input scripts.
Simulates the CPU pressing a certain input.
*/
function cpu_press() {
	cpu_inputs_bitflag = bitflag_write(cpu_inputs_bitflag, argument[0]);
}
/* Copyright 2023 Springroll Games / Yosi */