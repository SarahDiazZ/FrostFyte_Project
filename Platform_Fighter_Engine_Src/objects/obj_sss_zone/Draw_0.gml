///@description
//Selected animation
selected_animation_time = lerp(selected_animation_time, 0, 0.1);
draw_set_color(c_white);
draw_set_alpha(selected_animation_time);
draw_rectangle(bbox_left - 4, bbox_top - 4, (bbox_right - 1) + 4, (bbox_bottom - 1) + 4, false);
draw_set_alpha(1);

var _data = stage_data_get(stage);
draw_sprite(_data.sprite, _data.frame, x + (sprite_width / 2), y + (sprite_height / 2));
/* Copyright 2023 Springroll Games / Yosi */