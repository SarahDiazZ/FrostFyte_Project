///@param {asset} object1		The first object
///@param {asset} object2		The second object
/*
Returns true if the objects are the same, or if "object1" is a child of "object2".
Please note: This returns false if "object2" is a child of "object1".
*/
function object_is() {
	return (argument[0] == argument[1] || object_is_ancestor(argument[0], argument[1]));
}
/* Copyright 2023 Springroll Games / Yosi */