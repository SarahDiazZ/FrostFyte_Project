function main_menu_ui_stats_label_create() {
	var _tab = "    ";
	text = to_string
		(
		"Total Playtime: ",
		stats_get("playtime_hours"), ":", string_replace(string_format(stats_get("playtime_minutes"), 2, 0), " ", "0"), _tab,
		"Local Matches: ",
		stats_get("local_matches"), _tab,
		"Online Matches: ",
		stats_get("online_matches"), _tab,
		"Online Wins: ",
		stats_get("online_wins"),
		);
}
/* Copyright 2023 Springroll Games / Yosi */