//Haven Shader
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float fade_amount;

const vec3 white = vec3(0.75);

void main()
	{
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	if (gl_FragColor.r != 0.0 && gl_FragColor.r == gl_FragColor.g && gl_FragColor.g == gl_FragColor.b)
		{
		float red = (sin((v_vTexcoord.x * 25.0) + time) * 0.25);
		float green = (sin((v_vTexcoord.x * 5.0) + time) * 0.25);
		float blue = (cos((v_vTexcoord.y * 50.0) + time) * 0.25);
		gl_FragColor.rgb -= vec3(red, green, blue);
		}
	gl_FragColor.rgb *= fade_amount;
	}
/* Copyright 2023 Springroll Games / Yosi */