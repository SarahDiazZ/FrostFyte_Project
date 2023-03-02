/*
Replaces colors in the texture based on the given palette arrays.
*/
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 palette_base[32];
uniform vec4 palette_swap[32];
uniform int count;

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
	}
/* Copyright 2023 Springroll Games / Yosi */