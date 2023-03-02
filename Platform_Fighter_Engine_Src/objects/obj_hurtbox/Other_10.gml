///@description <Run by obj_game>
//Permanent hurtboxes
if (hurtbox_type == HURTBOX_TYPE.permanent)
	{
	//Snap to the player instance
	if (instance_exists(owner))
		{
		x = owner.x;
		y = owner.y;
	
		//Do not update invulnerability while in hitlag or shieldstun
		if (owner.self_hitlag_frame <= 0 && 
			(!object_is(owner.object_index, obj_player) || owner.shieldstun <= 0 || owner.state != PLAYER_STATE.hitlag))
			{
			hurtbox_inv_update();
			}
		image_xscale = abs(image_xscale) * owner.facing;
		}
	else
		{
		instance_destroy();
		}
	}
//Temporary attack hurtboxes
else if (hurtbox_type == HURTBOX_TYPE.attack)
	{
	//Lifetime
	if (destroy || lifetime <= 0)
		{
		instance_destroy();
		exit;
		}

	//When the user is in hitlag, the time on the hitboxes doesn't count down
	if (owner.self_hitlag_frame <= 0)
		{
		lifetime--;
		}
		
	//Move with the player
	if (instance_exists(owner))
		{
		x = xstart + (owner.x - owner_xstart);
		y = ystart + (owner.y - owner_ystart);
		}
	
	//Destroy if the player is no longer attacking
	if (owner.state != PLAYER_STATE.attacking)
		{
		destroy = true;
		}
	}
//Temporary shield hurtboxes
else if (hurtbox_type == HURTBOX_TYPE.shield)
	{
	//Move with the player
	if (instance_exists(owner))
		{
		x = owner.x + owner.shield_shift_x;
		y = owner.y + owner.shield_shift_y;
		//Resize
		var _size = shield_size_min + ((owner.shield_hp / owner.shield_max_hp) * owner.shield_size_multiplier);
		image_xscale = _size;
		image_yscale = _size;
		
		//Shield hurtbox is invincible if the player is invincible
		if (owner.hurtbox.inv_type == INV.invincible)
			{
			inv_type = INV.invincible;
			}
		else if (owner.hurtbox.inv_type == INV.normal)
			{
			inv_type = INV.shielding;
			}
		}
	
	//Destroy if the player is no longer shielding
	if (owner.state != PLAYER_STATE.shielding)
		{
		instance_destroy();
		exit;
		}
	}
/* Copyright 2023 Springroll Games / Yosi */