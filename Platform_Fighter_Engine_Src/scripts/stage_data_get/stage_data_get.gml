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
		case rm_peak: 
			_data.name = "Peak";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 0;
			break;
		case rm_battlefield:
			_data.name = "Battlefield";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 1;
			break;
		case rm_desert:
			_data.name = "Desert Pillar";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 2;
			break;
		case rm_large_campground:
			_data.name = "Large Campground";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 3;
			break;
		case rm_lava:
			_data.name = "Lava";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 4;
			break;
		case rm_clouds:
			_data.name = "Clouds";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 5;
			break;
		case rm_library:
			_data.name = "Library";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 6;
			break;
		case rm_small_campground:
			_data.name = "Small Campground";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 7;
			break;
		case rm_haven:
			_data.name = "Haven";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 8;
			break;
		case rm_warpgate: 
			_data.name = "Jotun Warp Gate";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 0;
			break;
		case rm_smiley_floats:
			_data.name = "Smiley Floats";
			_data.sprite = spr_stage_thumbnails;
			_data.frame = 9;
		}
		
	return _data;
}
/* Copyright 2023 Springroll Games / Yosi */