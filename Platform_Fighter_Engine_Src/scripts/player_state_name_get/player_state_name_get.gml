///@category Player Engine Scripts
///@param {int} state		The state to get the name of, from the PLAYER_STATE enum
/*
Returns the name of the given player state.
*/
function player_state_name_get() {
	switch(argument[0])
		{
		case PLAYER_STATE.idle: return "Idle";
		case PLAYER_STATE.crouching: return "Crouch";
		case PLAYER_STATE.walking: return "Walk";
		case PLAYER_STATE.walk_turnaround: return "Walk Turn";
		case PLAYER_STATE.dashing: return "Dash";
		case PLAYER_STATE.running: return "Run";
		case PLAYER_STATE.run_turnaround: return "Run Turn";
		case PLAYER_STATE.run_stop: return "Run Stop";
		
		case PLAYER_STATE.jumpsquat: return "Jumpsquat";
		case PLAYER_STATE.aerial: return "Aerial";
		
		case PLAYER_STATE.airdodging: return "Airdodge";
		case PLAYER_STATE.wavelanding: return "Waveland";
		case PLAYER_STATE.rolling: return "Roll";
		case PLAYER_STATE.shielding: return "Shield";
		case PLAYER_STATE.shield_release: return "Shield Release";
		case PLAYER_STATE.shield_break: return "Shield Break";
		case PLAYER_STATE.parry_press: return "Parry Press";
		case PLAYER_STATE.parry_stun: return "Parry Stun";
		case PLAYER_STATE.spot_dodging: return "Spot Dodge";
		
		case PLAYER_STATE.hitlag: return "Hitlag";
		case PLAYER_STATE.hitstun: return "Hitstun";
		case PLAYER_STATE.tumble: return "Tumble";
		case PLAYER_STATE.helpless: return "Helpless";
		case PLAYER_STATE.magnetized: return "Magnetized";
		case PLAYER_STATE.flinch: return "Flinch";
		case PLAYER_STATE.balloon: return "Balloon";
		case PLAYER_STATE.in_lag: return "Lag";
		case PLAYER_STATE.knockdown: return "Knockdown";
		case PLAYER_STATE.getup: return "Getup";
		
		case PLAYER_STATE.tech_rolling: return "Tech Roll";
		case PLAYER_STATE.teching: return "Tech";
		case PLAYER_STATE.tech_wall_jump: return "Tech Wall Jump";
		
		case PLAYER_STATE.ledge_snap: return "Ledge Snap";
		case PLAYER_STATE.ledge_hang: return "Ledge Hang";
		case PLAYER_STATE.ledge_getup: return "Ledge Getup";
		case PLAYER_STATE.ledge_jump: return "Ledge Jump";
		case PLAYER_STATE.ledge_roll: return "Ledge Roll";
		case PLAYER_STATE.ledge_attack: return "Ledge Attack";
		case PLAYER_STATE.ledge_tether: return "Ledge Tether";
		case PLAYER_STATE.ledge_trump: return "Ledge Trump";
		case PLAYER_STATE.wall_cling: return "Wall Cling";
		case PLAYER_STATE.wall_jump: return "Wall Jump";
		
		case PLAYER_STATE.knocked_out: return "KO";
		case PLAYER_STATE.star_ko: return "Star KO";
		case PLAYER_STATE.screen_ko: return "Screen KO";
		case PLAYER_STATE.respawning: return "Respawn";
		
		case PLAYER_STATE.attacking: return "Attack";
		case PLAYER_STATE.grabbing: return "Grab";
		case PLAYER_STATE.is_grabbed: return "Grabbed";
		case PLAYER_STATE.in_grab_release: return "Grab Release";
		
		case PLAYER_STATE.lost: return "Lost";
		case PLAYER_STATE.entrance: return "Entrance";
		}
	return "<Unknown State>";
}
/* Copyright 2023 Springroll Games / Yosi */