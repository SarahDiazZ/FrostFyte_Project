///@category Stages
///@param {int} room		The stage to get the data for
/*
Returns a struct with the following properties based on the given stage:
	- name : The name of the stage
	- sprite : The sprite of the thumbnail
	- frame : The subimage in the sprite
*/
function stage_data_get() {
	var _r = argument[0];
	var _data =
		{
		name : "",
		sprite : spr_blank,
		frame : 0,
		};
		
	switch(_r)
		{
		
		case rm_speedhighway: 
			_data.name = "Speed Highway";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 0;
			break;
		case rm_warpgate: 
			_data.name = "Jotun Warp Gate";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 1;
			break;
	
		}
		
	return _data;
}
/* Copyright 2023 Springroll Games / Yosi */