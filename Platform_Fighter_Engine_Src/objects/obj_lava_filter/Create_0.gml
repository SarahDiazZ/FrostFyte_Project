///@description
surf = surface_create(room_width, room_height);
lava_surf = surface_create(room_width, room_height);
clear_surf = true;
clear_lava_surf = true;

time = 0;

lava_tex = surface_get_texture(lava_surf);
lava_tw = texture_get_texel_width(lava_tex);
lava_th = texture_get_texel_height(lava_tex);

surf_tex = surface_get_texture(surf);
surf_tw = texture_get_texel_width(surf_tex);
surf_th = texture_get_texel_height(surf_tex);

samp = shader_get_sampler_index(shd_lava, "tex");
uni_t = shader_get_uniform(shd_lava, "texel");
uni_b = shader_get_uniform(shd_lava, "texel_base");
uni_i = shader_get_uniform(shd_lava, "time");
uni_f = shader_get_uniform(shd_lava, "fade_amount");
/* Copyright 2023 Springroll Games / Yosi */