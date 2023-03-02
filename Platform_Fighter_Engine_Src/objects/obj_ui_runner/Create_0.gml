///@category UI
/*
obj_ui_runner is the object that allows all of the other UI objects to work.
You must include the UI runner object in any room that uses other UI objects!
It runs the UI step scripts, keeps track of cursor collisions, and ensures that the UI buttons work correctly.
*/

ui_col_list = ds_list_create();
ui_instances = [];
ui_instance_current = 0;
cursors = ds_list_create();

only_one();
/* Copyright 2023 Springroll Games / Yosi */