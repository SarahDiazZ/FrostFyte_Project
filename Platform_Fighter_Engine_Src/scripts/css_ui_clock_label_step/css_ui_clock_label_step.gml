function css_ui_clock_label_step() {

	var _minute = current_minute;
	if (_minute < 10)
		{
		_minute = "0" + string(_minute);
		}
	else
		{
		_minute = string(_minute);
		}
	text = (string(current_hour) + ":" + _minute);
}
/* Copyright 2023 Springroll Games / Yosi */