function stage_smiley_floats_init() {
	//Timer
	if (!variable_struct_exists(custom_stage_struct, "timer"))
		{
		custom_stage_struct.timer = 0;
		}
	
	//Get instance IDs for all blocks at the start of the game
	if (!variable_struct_exists(custom_ids_struct, "float_ids"))
		{
		custom_ids_struct.float_ids =
			[
			//1
			inst_63C02600_3,
			inst_72FDBD26,
			inst_B431676,
			//2
			inst_D761DDA,
			//3
			inst_3DC45483,
			inst_7F8FB6B7,
			//4
			inst_6870CF8A,
			inst_603BF274,
			//5
			inst_33532444,
			//6
			inst_7D039A5B,
			inst_26E2504A,
			//7
			inst_D32F0C0,
			inst_41B4F566,
			inst_306FCECC,
			//8
			inst_4D0C14B9,
			//9
			inst_69C5A1ED,
			inst_16D16548,
			inst_75F2E9BD,
			//10
			inst_717385F7,
			//11
			inst_3F872778,
			//12
			inst_D45B980,
			//13
			inst_25023E86,
			//14
			inst_7C8DE3B5,
			//15
			inst_7BD8AB23,
			];
		}
}
/* Copyright 2023 Springroll Games / Yosi */