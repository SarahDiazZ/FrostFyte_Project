///@description Update certain stats
if (room == rm_css)
	{
	//Calculate how long the game has been open
	var _total_minutes = floor(date_minute_span(date_current_datetime(), starting_time));
	var _total_hours = stats_get("playtime_hours") + (_total_minutes div 60);
	_total_minutes = stats_get("playtime_minutes") + (_total_minutes mod 60);
	while(_total_minutes > 60)
		{
		_total_hours += 1;
		_total_minutes -= 60;
		}
	stats_set("playtime_hours", _total_hours);
	stats_set("playtime_minutes", _total_minutes);
	stats_save();
	
	starting_time = date_current_datetime();
	}
/* Copyright 2023 Springroll Games / Yosi */