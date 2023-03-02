///@category Gameplay
///@param {string} [default]		The default string to use if no match settings are set
/*
Returns a string with all of the match settings in the format: "Stock | Time | Stamina | Teams | Items".
*/
function match_settings_string() {
	var _default = argument_count > 0 ? argument[0] : "Training Mode";
	var _text = "";
	var _starting = true;

	if (match_has_stock_set())
		{
		_text += string(setting().match_stock) + " Stock";
		_starting = false;
		}
	if (match_has_time_set())
		{
		if (!_starting) then _text += ", ";
		_text += string(setting().match_time) + " Time";
		_starting = false;
		}
	if (match_has_stamina_set())
		{
		if (!_starting) then _text += ", ";
		_text += string(setting().match_stamina) + " Stamina";
		_starting = false;
		}
	if (setting().match_team_mode)
		{
		if (!_starting) then _text += ", ";
		_text += setting().match_team_attack ? "Teams" : "Teams*";
		_starting = false;
		}
	if (setting().match_items_enable)
		{
		if (!_starting) then _text += ", ";
		_text += "Items " + string(setting().match_items_frequency) + "%";
		_starting = false;
		}
	if (setting().match_screen_wrap)
		{
		if (!_starting) then _text += ", ";
		_text += "Wrap";
		_starting = false;
		}
	if (setting().match_ex_meter)
		{
		if (!_starting) then _text += ", ";
		_text += "EX";
		_starting = false;
		}
	if (setting().match_fs_meter)
		{
		if (!_starting) then _text += ", ";
		_text += "FS";
		_starting = false;
		}
		
	//Blank settings
	if (_starting)
		{
		_text = _default;
		}
	return _text;
}
/* Copyright 2023 Springroll Games / Yosi */