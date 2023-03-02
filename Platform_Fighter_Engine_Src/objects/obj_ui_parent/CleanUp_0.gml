//Remove from the instance array
with(obj_ui_runner)
	{
	var _len = array_length(ui_instances);
	for(var i = 0; i < _len; i++)
		{
		if (ui_instances[@ i] == other.id)
			{
			array_delete(ui_instances, i, 1);
			if (ui_instance_current > i) then ui_instance_current--;
			break;
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */