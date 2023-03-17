///@category Stages
/*
This object can be used to add a ledge to the stage.
The "image_xscale" ("Scale X" in the room editor) of the ledge determines which direction players can grab onto the ledge from.
*/
///@description Correct ledge direction
assert(image_xscale != 0, "[obj_ledge: Create] There is an instance of obj_ledge with an xscale of 0! Room: ", room_get_name(room), " X: ", x, " Y: ", y);
image_xscale = sign(image_xscale);
/* Copyright 2023 Springroll Games / Yosi */