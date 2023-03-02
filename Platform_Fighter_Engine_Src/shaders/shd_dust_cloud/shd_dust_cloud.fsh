/*
This shader gives a slight colored tint to dust clouds.
*/
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 color;
uniform float fade_amount;

void main()
	{
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	if (gl_FragColor.rgb == vec3(0.8862745098))
		{
		gl_FragColor.rgb = color * vec3(2.);
		}
	gl_FragColor.rgb *= fade_amount;
	}

/* Copyright 2023 Springroll Games / Yosi */