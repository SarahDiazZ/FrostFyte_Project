///@category Inputs
///@param {int} input		The input to release, from the INPUT enum
/*
To be used in <cpu_script_base> or character-specific CPU input scripts.
Simulates the CPU releasing a certain input.
*/
function cpu_release() {
	cpu_inputs_bitflag = bitflag_write(cpu_inputs_bitflag, argument[0], 0);
	cpu_inputs_bitflag = bitflag_write(cpu_inputs_bitflag, argument[0] + INPUT.LENGTH, 0);
}
/* Copyright 2023 Springroll Games / Yosi */