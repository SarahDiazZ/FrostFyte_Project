function item_attack3() {
	//Item Attack for character3
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Start a different attack based on what item you're holding
				var _obj = item_held.object_index;
				switch(_obj)
					{
					case obj_item_bat:
						//Use the default attack, because Scalar doesn't have a unique bat attack yet
						attack_start(item_bat_attack_default_script);
						break;
					default: crash("[item_attack0] Unrecognized held item: ", object_get_name(_obj));
					}
				return;
				}
			//Throw an error if no item attack was started
			case 0:
				{
				crash("[item_attack0] No item attack was started");
				break;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */