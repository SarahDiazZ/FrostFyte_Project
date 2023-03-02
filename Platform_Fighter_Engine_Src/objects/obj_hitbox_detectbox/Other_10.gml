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
			
			if (hitbox_can_hit_hurtbox(_hurtbox))
				{
				//Run the pre hit script
				hitbox_hit_script_run(pre_hit_script, _hurtbox);
			
				//Run the detectbox hit script
				with(_hurtbox.owner)
					{
					script_execute(_hurtbox.detectbox_hit, other.id, _hurtbox);
					}
					
				//Run the post hit script
				hitbox_hit_script_run(post_hit_script, _hurtbox);
				
				//Exit out if the detectbox is destroyed in the event/scripts
				if (!instance_exists(id)) then exit;
				}
			}
		}
	//Clear the DS
	//Double check that they still exist
	if (ds_exists(hurtbox_hit_list, ds_type_list))
		{
		ds_list_clear(hurtbox_hit_list);
		}
	}
/* Copyright 2023 Springroll Games / Yosi */