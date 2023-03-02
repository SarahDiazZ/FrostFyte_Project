///@description
if (destroy || lifetime <= 0)
	{
	instance_destroy();
	exit;
	}

var _frozen = false;
if (self_hitlag_frame > 0)
	{
	self_hitlag_frame = max(0, --self_hitlag_frame);
	_frozen = true;
	}
	
if (!_frozen)
	{
	hitbox_standard_actions();

	//Friction and Gravity
	hsp = approach(hsp, 0, fric);
	vsp += grav;

	//Move
	if (!pass_through_blocks)
		{
		projectile_move_x(hbounce, bounce_multiplier);
		projectile_move_y(vbounce, bounce_multiplier);
		}
	else
		{
		x += hsp;
		y += vsp;
		}
	
	if (destroy_outside_room)
		{
		if (!point_in_rectangle(x, y, 0, 0, room_width, room_height))
			{
			destroy = true;
			}
		}
	}

//Check for a collision with any hurtboxes
var _num = instance_place_list(x, y, obj_hurtbox, hurtbox_hit_list, false);
if (_num > 0)
	{
	//Loop through the hurtboxes, and sort them with the priority queue based on the sync_id
	ds_priority_clear(temp_priority_get());
	for(var i = 0; i < _num; i++)
		{
		var _id = hurtbox_hit_list[| i];
		ds_priority_add(temp_priority_get(), _id, _id.sync_id * (_id.check_first ? -1 : 1)); 
		}
	//Go through the sorted queue, and execute a script for each
	while(!ds_priority_empty(temp_priority_get()))
		{
		var _hurtbox = ds_priority_delete_min(temp_priority_get());
		
		//Hitboxes cannot hit their owners
		if (_hurtbox.owner == noone || _hurtbox.owner == owner) then continue;
		
		//Hitboxes cannot hit someone who has already been hit
		var _can_hit = true;
		for(var m = 0; m < array_length(hitbox_group_array); m++)
			{
			if (_hurtbox.owner == hitbox_group_array[@ m])
				{
				_can_hit = false;
				break;
				}
			}
			
		//Teams
		if (setting().match_team_mode)
			{
			if (!setting().match_team_attack && owner.player_team == _hurtbox.owner.player_team)
				{
				_can_hit = false;
				}
			}
		
		if (_can_hit)
			{
			//Run the pre hit script
			hitbox_hit_script_run(pre_hit_script, _hurtbox);
				
			//Run the projectile hit script
			with(_hurtbox.owner)
				{
				script_execute(_hurtbox.projectile_hit, other.id, _hurtbox);
				}
				
			//Run the post hit script
			hitbox_hit_script_run(post_hit_script, _hurtbox);
				
			//Exit out if the hitbox is destroyed in the scripts
			if (!instance_exists(id)) then exit;
			}
		}
	}
	
//Clear the DS
ds_list_clear(hurtbox_hit_list);

//Timer
if (!_frozen) then lifetime--;
/* Copyright 2023 Springroll Games / Yosi */