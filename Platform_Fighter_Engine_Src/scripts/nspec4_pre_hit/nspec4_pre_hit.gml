function nspec4_pre_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	var _player = _hurtbox.owner;
	
	if (object_is(_player.object_index, obj_player))
		{
		//Hitting a player in hitstun
		if (is_launched(_player))
			{
			_hitbox.base_knockback = 1;
			_hitbox.knockback_state = PLAYER_STATE.flinch;
			_hitbox.base_hitlag = 18;
			_hitbox.damage = 2;
			}
		//Counterhit
		else if (_player.state == PLAYER_STATE.attacking)
			{
			_hitbox.base_knockback = 6;
			_hitbox.knockback_scaling = 0.6;
			_hitbox.hitstun_scaling = 1.2;
			_hitbox.angle = 65;
			_hitbox.angle_flipper = FLIPPER.standard;
			_hitbox.base_hitlag = 18;
			_hitbox.hit_sfx = snd_hit_strong;
			_hitbox.knockback_state = PLAYER_STATE.hitstun;
			_hitbox.damage = 3;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */