///@description Called by obj_game

var _s = custom_entity_struct;

//Push players when spawned
if (!_s.pushed_players)
	{
	_s.pushed_players = true;
	with(obj_player)
		{
		move_out_of_blocks(90, sprite_height + 64);
		}
	}

//Destroy
_s.lifetime -= 1;
image_index = lerp(image_number, 0, _s.lifetime / 300);
if (_s.lifetime <= 0)
	{
	instance_destroy();
	}
/* Copyright 2023 Springroll Games / Yosi */