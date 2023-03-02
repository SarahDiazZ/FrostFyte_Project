///@category Player Engine Scripts
/*
Sets all of the states for the calling player to the "standard" scripts.
*/
function player_states_init() {
	my_states[@ PLAYER_STATE.idle			] =	standard_idle;
	my_states[@ PLAYER_STATE.crouching		] =	standard_crouching;
	my_states[@ PLAYER_STATE.walking		] = standard_walking;
	my_states[@ PLAYER_STATE.walk_turnaround] =	standard_walk_turnaround;
	my_states[@ PLAYER_STATE.dashing		] = standard_dashing;
	my_states[@ PLAYER_STATE.running		] = standard_running;
	my_states[@ PLAYER_STATE.run_turnaround	] = standard_run_turnaround;
	my_states[@ PLAYER_STATE.run_stop		] = standard_run_stop;
	
	my_states[@ PLAYER_STATE.jumpsquat		] =	standard_jumpsquat;
	my_states[@ PLAYER_STATE.aerial			] = standard_aerial;
	
	my_states[@ PLAYER_STATE.airdodging		] =	standard_airdodging;
	my_states[@ PLAYER_STATE.wavelanding	] = standard_wavelanding;
	my_states[@ PLAYER_STATE.rolling		] = standard_rolling;
	my_states[@ PLAYER_STATE.shielding		] = standard_shielding;
	my_states[@ PLAYER_STATE.shield_release	] = standard_shield_release;
	my_states[@ PLAYER_STATE.shield_break	] = standard_shield_break;
	my_states[@ PLAYER_STATE.parry_press	] =	standard_parry_press;
	my_states[@ PLAYER_STATE.parry_stun		] =	standard_parry_stun;
	my_states[@ PLAYER_STATE.spot_dodging	] =	standard_spot_dodging;
	
	my_states[@ PLAYER_STATE.hitlag			] = standard_hitlag;
	my_states[@ PLAYER_STATE.hitstun		] = standard_hitstun;
	my_states[@ PLAYER_STATE.tumble			] = standard_tumble;
	my_states[@ PLAYER_STATE.helpless		] =	standard_helpless;
	my_states[@ PLAYER_STATE.magnetized		] =	standard_magnetized;
	my_states[@ PLAYER_STATE.flinch			] =	standard_flinch;
	my_states[@ PLAYER_STATE.in_lag			] = standard_in_lag;
	my_states[@ PLAYER_STATE.balloon		] = standard_balloon;
	my_states[@ PLAYER_STATE.knockdown		] =	standard_knockdown;
	my_states[@ PLAYER_STATE.getup			] =	standard_getup;
	
	my_states[@ PLAYER_STATE.tech_rolling	] = standard_tech_rolling;
	my_states[@ PLAYER_STATE.teching		] =	standard_teching;
	my_states[@ PLAYER_STATE.tech_wall_jump	] =	standard_tech_wall_jump;
	
	my_states[@ PLAYER_STATE.ledge_snap		] =	standard_ledge_snap;
	my_states[@ PLAYER_STATE.ledge_hang		] =	standard_ledge_hang;
	my_states[@ PLAYER_STATE.ledge_getup	] =	standard_ledge_getup;
	my_states[@ PLAYER_STATE.ledge_jump		] =	standard_ledge_jump;
	my_states[@ PLAYER_STATE.ledge_roll		] =	standard_ledge_roll;
	my_states[@ PLAYER_STATE.ledge_attack	] =	standard_ledge_attack;
	my_states[@ PLAYER_STATE.ledge_tether	] =	standard_ledge_tether;
	my_states[@ PLAYER_STATE.ledge_trump	] =	standard_ledge_trump;
	my_states[@ PLAYER_STATE.wall_cling		] =	standard_wall_cling;
	my_states[@ PLAYER_STATE.wall_jump		] =	standard_wall_jump;
	
	my_states[@ PLAYER_STATE.knocked_out	] =	standard_knocked_out;
	my_states[@ PLAYER_STATE.star_ko		] =	standard_star_ko;
	my_states[@ PLAYER_STATE.screen_ko		] =	standard_screen_ko;
	my_states[@ PLAYER_STATE.respawning		] =	standard_respawning;
	
	my_states[@ PLAYER_STATE.attacking		] =	standard_attacking;
	my_states[@ PLAYER_STATE.grabbing		] =	standard_grabbing;
	my_states[@ PLAYER_STATE.is_grabbed		] =	standard_is_grabbed;
	my_states[@ PLAYER_STATE.in_grab_release] =	standard_grab_release;
	
	my_states[@ PLAYER_STATE.lost			] =	standard_lost;
	my_states[@ PLAYER_STATE.entrance		] =	standard_entrance;
}
/* Copyright 2023 Springroll Games / Yosi */