///@category Startup
/*
This object replicates a window border, and is intended to be used if the "borderless window" setting in GameMaker is turned on.
Please note: This is a persistent object.
*/
///@description
only_one();
window_fade = 0;
window_hover = false;
window_dragged = false;
window_drag_x = 0;
window_drag_y = 0;
window_start_x = 0;
window_start_y = 0;
bar_height = 32;
disable = web_export;

//Buttons
button_exit_fade = 0;
button_full_fade = 0;
button_size_fade = 0;
/* Copyright 2023 Springroll Games / Yosi */