///@category Inputs
///@param {int} input		The input to hold, from the INPUT enum
/*
To be used in <cpu_script_base> or character-specific CPU input scripts.
Simulates the CPU holding down a certain input.
*/
function cpu_hold() {
	cpu_inputs_bitflag = bitflag_write(cpu_inputs_bitflag, argument[0] + INPUT.LENGTH);
}
/* Copyright 2023 Springroll Games / Yosi */