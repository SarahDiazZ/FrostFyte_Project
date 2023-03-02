//Pre-hit script for tripping opponents
function trip_pre_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	var _opponent = _hurtbox.owner;
	
	//Only trip grounded opponents below 50% who aren't already in knockdown
	if (object_is(_opponent.object_index, obj_player))
		{
		if (_opponent.damage <= 50)
			{
			if (_opponent.state != PLAYER_STATE.knockdown &&
				_opponent.state != PLAYER_STATE.getup)
				{
				var _grounded = false;
				with(_opponent)
					{
					_grounded = on_ground();
					break;
					}
				if (_grounded)
					{
					_hitbox.knockback_state = PLAYER_STATE.knockdown;
					camera_shake(0, 2);
					}
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */