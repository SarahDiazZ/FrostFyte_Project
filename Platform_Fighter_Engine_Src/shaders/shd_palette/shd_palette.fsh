/*
Replaces colors in the texture based on the given palette arrays.
Additionally, there are uniforms for fading the texture, brightening the texture, changing the alpha, and adding an outline.
*/
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 palette_base[32];
uniform vec4 palette_swap[32];
uniform int count;

uniform float fade_value;
uniform float light_value;
uniform float alpha_value;
uniform int outline;
uniform vec2 outline_texel;
uniform vec4 outline_color;
uniform vec3 tint;
uniform vec4 flash;

const float tolerance = 0.05;

void main()
	{
	//Check if the color is any of the base colors
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	for(int i = 0; i < 32; i++)
		{
		if (i >= count) break;
		if (gl_FragColor.a != 0. && abs(distance(gl_FragColor, palette_base[i])) <= tolerance)
			{
			//Replace it with the correct color
			gl_FragColor = v_vColour * (palette_swap[i] + (gl_FragColor - palette_base[i]));
			break;
			}
		}
	
	//Tint / Flash
	gl_FragColor.rgb += tint;
	gl_FragColor.rgb = mix(gl_FragColor.rgb, flash.rgb, flash.a);
	
	//Outline
	if (outline == 1 && gl_FragColor.a == 0.)
		{
		if (texture2D(gm_BaseTexture, v_vTexcoord + vec2( outline_texel.x, 0.)).a > 0. ||
			texture2D(gm_BaseTexture, v_vTexcoord + vec2(-outline_texel.x, 0.)).a > 0. ||
			texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.,  outline_texel.y)).a > 0. ||
			texture2D(gm_BaseTexture, v_vTexcoord + vec2(0., -outline_texel.y)).a > 0.)
			{
			gl_FragColor = outline_color;
			}
		}
		
	//Values
	gl_FragColor.rgb += light_value;
	gl_FragColor.rgb *= fade_value;
	gl_FragColor.a	 *= alpha_value;
	}
/* Copyright 2023 Springroll Games / Yosi */