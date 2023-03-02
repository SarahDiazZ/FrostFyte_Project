/*
Used to skew the text on the win screen.
*/
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

void main()
	{
    vec4 object_space_pos = vec4( in_Position.x / 4., in_Position.y, in_Position.z, 1.0);
    gl_Position = (gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos) + vec4(in_Position.x / 1000., in_Position.x / -1000., 0.0, in_Position.x / 750.);
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
	v_vPosition = in_Position.xy;
	}
/* Copyright 2023 Springroll Games / Yosi */