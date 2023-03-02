///@category Attacking
///@param {int/real} damage		The damage to calculate the color for
/*
Returns the color that the given damage would be drawn with on the HUD.
Lower percents will return a lighter yellowish color, while higher percents returns a darker red color.
*/
function calculate_damage_color() {
	var d = argument[0];
	if (d < 15)
		{
		return c_white;
		}
	if (d < 40)
		{
		return merge_color(c_white, c_yellow, (d - 15) / 40);
		}
	if (d < 80)
		{
		return merge_color(c_yellow, c_orange, (d - 40) / 80);
		}
	if (d < 140)
		{
		return merge_color(c_orange, c_red, (d - 80) / 140);
		}
	else
		{
		return merge_color(c_red, c_dkgray, min((d - 140) / 300, 1));
		}
}
/* Copyright 2023 Springroll Games / Yosi */