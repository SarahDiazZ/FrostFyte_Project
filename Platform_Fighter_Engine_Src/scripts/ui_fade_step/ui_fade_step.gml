function ui_fade_step() {
	if (fade != fade_goal)
		{
		fade = lerp(fade, fade_goal, fade_speed);
		if (abs(fade - fade_goal) < 0.01)
			{
			fade = fade_goal;
			}
		}


}

/* Copyright 2023 Springroll Games / Yosi */