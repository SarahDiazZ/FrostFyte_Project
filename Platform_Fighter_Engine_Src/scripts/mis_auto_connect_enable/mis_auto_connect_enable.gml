///@category Menu Input System
///@param {bool} enable		Whether to enable auto connecting or not.
/*
Choose whether the Menu Input System will automatically connect detected devices or not.
*/
function mis_auto_connect_enable() {
	mis_data().auto_connect = argument[0];
	return;
}
/* Copyright 2023 Springroll Games / Yosi */