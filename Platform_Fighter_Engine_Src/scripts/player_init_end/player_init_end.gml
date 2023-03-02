///@category Player Engine Scripts
///@param {bool} [entrance_state]		Whether to set the player to the entrance state or not
/*
Finishes the initialization of the <obj_player> after it has been assigned certain values in <players_spawn>.
You can optionally choose to NOT set the player to the entrance state. This functionality is mainly intended for <switch_character>.
*/
function player_init_end() {
	var _entrance = argument_count > 0 ? argument[0] : true;

	//Called by obj_game after the device is assigned to the player
	
	//Set up character specific variables
	script_execute(character_script);

	//Character Name
	character_name = character_data_get(character, CHARACTER_DATA.name);

	//Palette variables
	player_palette_reset();

	//Sprites
	portrait = character_data_get(character, CHARACTER_DATA.portrait);
	render = character_data_get(character, CHARACTER_DATA.render);
	stock_sprite = character_data_get(character, CHARACTER_DATA.stock_sprite);
	
	//Permanent Hurtbox
	hurtbox = hurtbox_create_permanent(hurtbox_sprite);

	//Animation base
	anim_reset();

	//Entrance state
	if (_entrance) then state_set(PLAYER_STATE.entrance);

	//Collision box
	collision_box_change();

	//Move to the back
	player_move_to_back();
	
	//Move up out of blocks
	for(var m = 0; 
		(collision(x, y, [FLAG.solid, FLAG.plat], false, obj_collidable, true) && !on_ground()) &&
		m < 9999; 
		m++)
		{
		y--;
		}
		
	//Init Attack Cooldown and Uses Maps
	var _attacks = variable_struct_get_names(my_attacks);
	for(var i = 0; i < array_length(_attacks); i++)
		{
		//Script index
		var _attack = string(my_attacks[$ _attacks[@ i]]);
		attack_cooldowns[$ _attack] = 0;
		attack_uses[$ _attack] = -1;
		}
		
	//Final Smash Meter
	if (setting().match_fs_meter)
		{
		callback_add(callback_passive, final_smash_meter_passive, CALLBACK_TYPE.permanent);
		callback_add(callback_hud, final_smash_meter_hud, CALLBACK_TYPE.permanent);
		}
		
	//EX Meter
	if (setting().match_ex_meter)
		{
		callback_add(callback_hit, ex_meter_player_hit, CALLBACK_TYPE.permanent);
		callback_add(callback_hurt, ex_meter_player_hurt, CALLBACK_TYPE.permanent);
		callback_add(callback_passive, ex_meter_passive, CALLBACK_TYPE.permanent);
		callback_add(callback_overhead, ex_meter_overhead, CALLBACK_TYPE.permanent);
		}
}
/* Copyright 2023 Springroll Games / Yosi */