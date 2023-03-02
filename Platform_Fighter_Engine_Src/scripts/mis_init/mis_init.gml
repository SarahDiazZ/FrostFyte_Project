///@category Menu Input System
/*
Initializes the Menu Input System object, allowing any other objects in the room to call MIS functions.
The MIS connect_callback is reset upon calling this function.
If the room is switched, <obj_mis_system> will be destoyed as it is not persistent.
This function also contains MIS specific enums and the global mis_data function, which is used for the MIS backend and stores default values for MIS properties.
*/
function mis_init() {
	if (!instance_exists(obj_mis_system)) 
		{
		instance_create_layer(0, 0, layer, obj_mis_system);
		mis_data().connect_callback = undefined;
		}
}

//Global data
function mis_data() {
	static data = 
		{
		devices :				[],
		device_id_current :		0,
		max_controllers :		8,
		max_keyboards :			1,
		max_custom :			8,
		max_total :				8,
		auto_connect :			true,
		controller_deadzone :	0.35,
		keyboard_stick : 
			[
			menu_right_key, 
			menu_left_key, 
			menu_up_key, 
			menu_down_key,
			],
		controller_inputs : 
			[
			menu_confirm_button, 
			menu_back_button, 
			menu_option_button, 
			menu_remove_button, 
			menu_page_next_button, 
			menu_page_last_button, 
			menu_start_button, 
			menu_select_button,
			],
		keyboard_inputs : 
			[
			menu_confirm_key, 
			menu_back_key, 
			menu_option_key, 
			menu_remove_key, 
			menu_page_next_key, 
			menu_page_last_key, 
			menu_start_key, 
			menu_select_key,
			],
		connect_callback :		undefined,
		};
	return data;
}

//Device properties
enum MIS_DEVICE_PROPERTY 
	{
	device_id,
	port_number,
	device_type,
	inputs,
	stick_values,
	custom,
	}
enum MIS_INPUT 
	{
	confirm,
	back,
	option,
	remove,
	page_next,
	page_last,
	start,
	select,
	
	LENGTH,
	}
enum MIS_DEVICE_TYPE 
	{
	controller,
	keyboard,
	custom,
	none,
	}
/* Copyright 2023 Springroll Games / Yosi */