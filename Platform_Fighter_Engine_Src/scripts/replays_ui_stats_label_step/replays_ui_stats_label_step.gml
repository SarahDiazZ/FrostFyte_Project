function replays_ui_stats_label_step() {
	text = "";
	text += "Replays: " + string(array_length(obj_replays_ui.replay_array)) + "\n";
	text += "Clips: " + string(obj_replays_ui.replay_clip_number) + "\n";
	text += "Unknown Files: " + string(obj_replays_ui.replay_unknown_number) + "\n";
}
/* Copyright 2023 Springroll Games / Yosi */