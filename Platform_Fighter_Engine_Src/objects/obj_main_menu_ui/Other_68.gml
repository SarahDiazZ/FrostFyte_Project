///@description
var _type = async_load[? "type"];
if (_type == network_type_data) 
	{
	var _buff = async_load[? "buffer"];
	buffer_seek(_buff, buffer_seek_start, 0);
	
	//Make sure the packet isn't a GGMR packet
	if (buffer_peek(_buff, buffer_tell(_buff), buffer_u8) != 123) then exit;
	var _json = buffer_read(_buff, buffer_text);
	var _packet = json_parse(_json);
	var _type = _packet.type;
	var _data = _packet.data;
	if (is_undefined(_type) || is_undefined(_data))
		{
		crash("[obj_main_menu_ui: Async - Networking] Received a packet with an invalid type (", _type, ") or invalid data (", _data, ")");
		}
		
	//Different types of server response packets
	switch(_type)
		{
		case "news":
			engine().main_menu_news = string(_data);
			break;
		}
	}
/* Copyright 2023 Springroll Games / Yosi */