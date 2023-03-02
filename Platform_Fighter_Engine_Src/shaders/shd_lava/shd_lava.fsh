//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform sampler2D tex;
uniform vec2 texel;
uniform vec2 texel_base;
uniform float time;
uniform float fade_amount;

void main() {
	//Only pure red is affected
	vec4 red = vec4(1., 0., 0., 1.);
	if (texture2D(gm_BaseTexture, v_vTexcoord) == red) {
		float posx = (v_vTexcoord.x / texel_base.x) * texel.x;
		float posy = (v_vTexcoord.y / texel_base.y) * texel.y;
		
		gl_FragColor = texture2D(tex, vec2(posx + sin((v_vTexcoord.y / texel.y) + time) * texel.x, posy));
		
		//Top of the lava
		if (texture2D(gm_BaseTexture, v_vTexcoord + vec2(0., -texel.y)) != red) {
			gl_FragColor.rgba += vec4(.25, .25, -.25, 1.);
		} else if (texture2D(gm_BaseTexture, v_vTexcoord + vec2(0., -texel.y * 2.)) != red) {
			gl_FragColor.rgba += vec4(.15, .15, -.15, 1.);
		} else if (texture2D(gm_BaseTexture, v_vTexcoord + vec2(0., -texel.y * 3.)) != red) {
			gl_FragColor.rgba += vec4(.05, .05, -.05, 1.);
		}
		gl_FragColor.a = 1.0;
	} else {
		gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
		//* Glowing
		if (texture2D(gm_BaseTexture, v_vTexcoord + vec2(0., texel.y)) == red) {
			gl_FragColor.rgba += vec4(.25, .18, -.25, .5);
		} else if (texture2D(gm_BaseTexture, v_vTexcoord + vec2(0., texel.y * 2.)) == red) {
			gl_FragColor.rgba += vec4(.18, .15, -.15, .5);
		} else if (texture2D(gm_BaseTexture, v_vTexcoord + vec2(0., texel.y * 3.)) == red) {
			gl_FragColor.rgba += vec4(.15, .08, -.05, .5);
		} else if (texture2D(gm_BaseTexture, v_vTexcoord + vec2(0., texel.y * 4.)) == red) {
			gl_FragColor.rgba += vec4(.08, .05, -.15, .5);
		} else if (texture2D(gm_BaseTexture, v_vTexcoord + vec2(0., texel.y * 5.)) == red) {
			gl_FragColor.rgba += vec4(.05, 0., -.05, .5);
		}
		//*/
	}
	//Fading
	gl_FragColor.rgb *= fade_amount;
}
/* Copyright 2023 Springroll Games / Yosi */