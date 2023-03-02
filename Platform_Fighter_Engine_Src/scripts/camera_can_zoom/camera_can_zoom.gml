///@category Gameplay
/*
Returns if the camera is allowed to zoom or not.
*/
function camera_can_zoom() {
	return (setting().camera_zoom_enable || camera_special_zoom_enable);
}
/* Copyright 2023 Springroll Games / Yosi */