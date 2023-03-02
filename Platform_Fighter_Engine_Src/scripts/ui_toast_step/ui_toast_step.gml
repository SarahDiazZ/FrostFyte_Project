function ui_toast_step() {
	lifetime--;

	if (lifetime <= 10)
		{
		image_alpha = lifetime / 10;
		}

	if (lifetime <= 0)
		{
		instance_destroy();
		}
}
/* Copyright 2023 Springroll Games / Yosi */