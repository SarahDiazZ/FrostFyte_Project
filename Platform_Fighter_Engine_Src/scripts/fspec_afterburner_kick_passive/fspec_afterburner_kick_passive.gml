function fspec_afterburner_kick_passive() {
	//Limits the number of uses of afterburner kick.
	if (!(state == PLAYER_STATE.attacking && attack_script == fspec_afterburner_kick))
		{
		if (on_ground())
			{
			attack_uses_set(2, fspec_afterburner_kick);
			attack_cooldown_set(0, fspec_afterburner_kick);
			}
		}
	if (is_knocked_out())
		{
		attack_uses_set(2, fspec_afterburner_kick);
		attack_cooldown_set(0, fspec_afterburner_kick);
		}
}
/* Copyright 2023 Springroll Games / Yosi */