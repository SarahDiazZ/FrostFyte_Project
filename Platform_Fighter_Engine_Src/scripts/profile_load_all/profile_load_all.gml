///@category Profiles
///@param {string} filename			The file to load profiles from.
/*
Replaces the profiles list with the profiles stored in the <savefile_profiles> file.
If a filename is given, it loads from that file instead.
*/
function profile_load_all() {
	try 
		{
		var _file = argument_count > 0 ? argument[0] : savefile_profiles;
		if (!file_exists(_file))
			{
			_file = "default_profiles.sav";
			}

		var _json = string_file_load(_file);
		var _profile_data = json_parse(_json);
	
		//If the profile savefile is not in the correct format, alert the player
		if (!is_struct(_profile_data) || !variable_struct_exists(_profile_data, "list") || !is_array(_profile_data.list))
			{
			if (!web_export) then show_message(to_string("The profiles save file (", _file, ") is not in the correct format! The file will be deleted."));
			file_copy(_file, "deleted_" + _file);
			file_delete(_file);
			if (_file != "default_profiles.sav")
				{
				//Attempt to load the default profile
				profile_load_all("default_profiles.sav");
				}
			else
				{
				//If the default profile is corrupted, can't do anything about that.
				engine().profiles = [];
				}
			return;
			}
		
		//If the profile savefile is not the correct version, alert the player
		if (string(_profile_data.version) != version_string)
			{
			if (!web_export) then show_message(to_string("The profiles save file (", _file, ") is not the correct version! Profiles may not load correctly."));
			file_copy(_file, string(_profile_data.version) + "_" + _file);
			engine().profiles = _profile_data.list;
			profile_save_all();
			log("Loaded and Re-saved All Profiles (", _json, ")");
			}
		else
			{
			//Load data
			engine().profiles = _profile_data.list;
			log("Loaded All Profiles (", _json, ")");
			}
			
		//Make sure all profiles have valid data
		for(var i = 0; i < array_length(engine().profiles); i++)
			{
			var _profile = engine().profiles[@ i];
			
			//Custom controls
			var _cc = _profile[@ PROFILE.custom_controls];
			if (!is_struct(_cc) || 
				!variable_struct_exists(_cc, "inputs_controller") || 
				!variable_struct_exists(_cc, "inputs_keyboard") || 
				!variable_struct_exists(_cc, "inputs_touch") ||
				!variable_struct_exists(_cc, "scs") ||
				!variable_struct_exists(_cc, "acs"))
				{
				//This check is needed because the Opera GX export will not throw an error here otherwise
				throw ("The profile struct does not have all of the necessary properties");
				}
			if (array_length(_cc.inputs_controller) < CC_INPUT_CONTROLLER.LENGTH) then array_resize(_cc.inputs_controller, CC_INPUT_CONTROLLER.LENGTH);
			if (array_length(_cc.inputs_keyboard) < CC_INPUT_KEYBOARD.LENGTH) then array_resize(_cc.inputs_keyboard, CC_INPUT_KEYBOARD.LENGTH);
			if (array_length(_cc.inputs_touch) < CC_INPUT_TOUCH.LENGTH) then array_resize(_cc.inputs_touch, CC_INPUT_TOUCH.LENGTH);
			if (array_length(_cc.scs) < SCS.LENGTH) then array_resize(_cc.scs, SCS.LENGTH);
			if (array_length(_cc.acs) < ACS.LENGTH) then array_resize(_cc.acs, ACS.LENGTH);
			
			//Favorite colors
			var _favorite_colors = _profile[@ PROFILE.favorite_colors];
			if (array_length(_favorite_colors) < character_count()) then array_resize(_favorite_colors, character_count());
			}
		}
	catch (_e)
		{
		//HTML build seems to load the wrong file on itch.io, so this should prevent the pop up from being displayed
		if (!web_export) then show_message("There was an error reading the profiles file. The file will be deleted. (" + string(_e) + ")");
		file_delete(_file);
		if (_file != "default_profiles.sav")
			{
			//Attempt to load the default profile
			profile_load_all("default_profiles.sav");
			}
		log(_e);
		return;
		}
}
/* Copyright 2023 Springroll Games / Yosi */