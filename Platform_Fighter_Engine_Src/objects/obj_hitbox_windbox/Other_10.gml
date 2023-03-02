///@description <Run by obj_game>
if (destroy || lifetime == 0)
	{
	instance_destroy();
	exit;
	}
	
hitbox_standard_actions();

//Nothing happens if the owner is somehow destroyed
if (instance_exists(owner))
	{
	//Move with the player
	x = xstart + (owner.x - owner_xstart);
	y = ystart + (owner.y - owner_ystart);

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
			
			//Windboxes cannot hit someone who has already been hit, unless it is flagged as multihit
			var _already_hit = false;
			if (!windbox_multihit)
				{
				var _array = owner.hitbox_groups[@ hitbox_group];
				_already_hit = array_contains(_array, _hurtbox.owner);
				}
				
			//Windboxes can always hit teammates
			
			if (!_already_hit)
				{
				//Run the pre hit script
				hitbox_hit_script_run(pre_hit_script, _hurtbox);
			
				//Run the windbox hit script
				with(_hurtbox.owner)
					{
					script_execute(_hurtbox.windbox_hit, other.id, _hurtbox);
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
	}
/* Copyright 2023 Springroll Games / Yosi */