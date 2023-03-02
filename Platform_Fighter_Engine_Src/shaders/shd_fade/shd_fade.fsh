/*
Multiplies the RGB values of the texture by the given uniform.
*/
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float fade_amount;

void main()
	{
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	gl_FragColor.rgb *= fade_amount;
	}
/* Copyright 2023 Springroll Games / Yosi */