///@param {int} key			The key number
///@param {bool} [long]		Whether to use longer key names or not
/*
Returns the name of the given key. If the key isn't recognized, a dash is returned.
By default, shorter key names are used, but you can set the optional argument to true if you want longer key names.
*/
function key_to_string() {
	var _k = argument[0];
	var _l = argument_count > 1 ? argument[1] : false;
	
	//Array catch
	if (is_array(_k)) then _k = _k[@ 0];
	
	//Characters
	if (_k >= 48 && _k < 91) 
		{ 
		return chr(_k); 
		}
	
	//Special
	switch(_k)
		{
	    case -1: return "-";
	    case 8: return _l ? "Backspace" : "Back";
	    case 9: return "Tab";
	    case 13: return "Enter";
	    case 16: return "Shift";
	    case 17: return _l ? "Control" : "Ctrl";
	    case 18: return "Alt";
	    case 19: return "Break";
	    case 20: return _l ? "Caps Lock" : "CAPS";
	    case 27: return _l ? "Escape" : "Esc";
		case 32: return "Space";
	    case 33: return _l ? "Page Up" : "PG Up";
	    case 34: return _l ? "Page Down" : "PG Down";
	    case 35: return "End";
	    case 36: return "Home";
	    case 37: return "Left";
	    case 38: return "Up";
	    case 39: return "Right";
	    case 40: return "Down";
	    case 45: return "Insert";
	    case 46: return "Delete";
	    case 96: return _l ? "Numpad 0" : "Num 0";
	    case 97: return _l ? "Numpad 1" : "Num 1";
	    case 98: return _l ? "Numpad 2" : "Num 2";
	    case 99: return _l ? "Numpad 3" : "Num 3";
	    case 100: return _l ? "Numpad 4" : "Num 4";
	    case 101: return _l ? "Numpad 5" : "Num 5";
	    case 102: return _l ? "Numpad 6" : "Num 6";
	    case 103: return _l ? "Numpad 7" : "Num 7";
	    case 104: return _l ? "Numpad 8" : "Num 8";
	    case 105: return _l ? "Numpad 9" : "Num 9";
	    case 106: return _l ? "Numpad *" : "Num *";
	    case 107: return _l ? "Numpad +" : "Num +";
	    case 109: return _l ? "Numpad -" : "Num -";
	    case 110: return _l ? "Numpad ." : "Num .";
	    case 111: return _l ? "Numpad /" : "Num /";
	    case 112: return "F1";
	    case 113: return "F2";
	    case 114: return "F3";
	    case 115: return "F4";
	    case 116: return "F5";
	    case 117: return "F6";
	    case 118: return "F7";
	    case 119: return "F8";
	    case 120: return "F9";
	    case 121: return "F10";
	    case 122: return "F11";
	    case 123: return "F12";
	    case 144: return "Num Lock";
	    case 145: return "Scroll Lock";
		case 162: return _l ? "Left Ctrl" : "L Ctrl";
		case 163: return _l ? "Right Ctrl" : "R Ctrl";
	    case 186: return ";";
	    case 187: return "=";
	    case 188: return ",";
	    case 189: return "-";
	    case 190: return ".";
	    case 191: return "\\";
	    case 192: return "`";
	    case 219: return "/";
	    case 220: return "[";
	    case 221: return "]";
	    case 222: return "'";
		}
	return "-";
}
/* Copyright 2023 Springroll Games / Yosi */