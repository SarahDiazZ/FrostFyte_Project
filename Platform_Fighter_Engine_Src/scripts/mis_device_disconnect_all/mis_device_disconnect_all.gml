///@category Menu Input System
/*
Disconnects all devices from the Menu Input System.
*/
function mis_device_disconnect_all() {
	//Clear the array
	mis_data().devices = [];
	return;
}
/* Copyright 2023 Springroll Games / Yosi */