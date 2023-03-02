///@category Debugging
///@param {string} [filename]           The .json file to load
/*
Loads data from a .json file, which can then be retrieved through the <live_values> function.
By default, the "live_values.json" file is loaded.
Warning: This is intended for debug use only, since the files can be changed by players at any time.
*/
function live_values_reload() {
    var _file = argument_count > 0 ? argument[0] : "live_values.json";
    if (file_exists(_file))
        {
        try
            {
            var _b = buffer_load(_file);
            var _json = buffer_read(_b, buffer_string);
            var _data = json_parse(_json);
            if (_data != undefined && is_struct(_data))
                {
				var _version = variable_struct_get(_data, "version");
                if (is_undefined(_version) || _version != version_string)
                    {
					log("The file ", _file, " has the incorrect version (", _version, ")");
					}
					
	            live_values_stored_data().struct = _data;
	            live_values_stored_data().reloaded_time = timestamp_create();
	            live_values_stored_data().size = buffer_get_size(_b);
	            live_values_stored_data().filename = _file;
	            log("Reloaded the live values from ", _file, " at ", live_values_stored_data().reloaded_time);
                }
            else
                {
                throw("Invalid data (" + string(_data) + "), must be a struct!");
                }
            }
        catch (_e)
            {
            log("[live_values_reload] Encountered an error when loading the file ", _file);
            log(_e);
            }
        finally
            {
            buffer_delete(_b);
            }
        }
    else
        {
        log("[live_values_reload] The file ", _file, " does not exist in the local app data!");
        
        if (_file == "live_values.json")
            {
            var _b = buffer_create(1, buffer_grow, 1);
            var _default_struct =
                {
                version: version_string,
                }
            buffer_write(_b, buffer_string, json_stringify(_default_struct));
            buffer_save(_b, _file);
            buffer_delete(_b);
            log("Saved a blank live_values.json file");
            }
        }
}
/* Copyright 2023 Springroll Games / Yosi */