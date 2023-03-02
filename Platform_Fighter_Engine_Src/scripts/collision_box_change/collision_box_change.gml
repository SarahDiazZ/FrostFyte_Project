///@category Collisions
///@param {asset} [mask_sprite]			The sprite to use as a collision mask
///@param {string} [bbox_anchor]		The bounding box side name to act as an anchor
/*
This function can be used to change the collision mask of a player object.
If no mask_sprite is given, the player will revert to their original "collision_box" sprite.
You can also optionally give an anchor name - either "top", "bottom", "left", or "right", and the function will move the player after the collision box change so that coordinate is still the same.
After changing collision masks, the player will attempt to move out of blocks. This is to prevent the player from getting stuck if the new mask puts them inside a block.
*/
function collision_box_change() {
	var _mask = argument_count > 0 ? argument[0] : collision_box;
	
	//Turn around collision box if needed
	if (facing != 0)
		{
		image_xscale = sign(facing);
		}
	
	
	
	//Anchor
	if (argument_count > 1)
		{
		switch(argument[1])
			{
			case "top":
				var _anchor = bbox_top;
				mask_index = _mask;
				y += _anchor - bbox_top;
				break;
			case "bottom":
				var _anchor = (bbox_bottom - 1);
				mask_index = _mask;
				y += _anchor - (bbox_bottom - 1);
				break;
			case "left":
				var _anchor = bbox_left;
				mask_index = _mask;
				x += _anchor - bbox_left;
				break;
			case "right":
				var _anchor = (bbox_right - 1);
				mask_index = _mask;
				x += _anchor - (bbox_right - 1);
				break;
			default: crash("[collision_box_change] Invalid anchor name (", argument[1], ")");
			}
		}
	else
		{
		//Mask change
		mask_index = _mask;
		}
	
	//Handles collisions
	move_out_of_blocks(-1);
}
/* Copyright 2023 Springroll Games / Yosi */