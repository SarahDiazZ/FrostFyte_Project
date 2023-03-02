///@description Hitbox lifetime

//When the user is in hitlag, the time on the hitboxes doesn't count down
if (owner.self_hitlag_frame <= 0)
	{
	lifetime--;
	}
	
//Destroy if the player was hit
if (owner.state != PLAYER_STATE.attacking)
	{
	destroy = true;
	}
	
/* Copyright 2023 Springroll Games / Yosi */