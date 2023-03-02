///@category Collisions
/*
Moves a player to the ledge getup position.
If <ledge_getup_check_collision> is true, players cannot do a ledge getup if there is a solid collidable object in the way.
Otherwise, players will get up and then move out of blocks upwards if necessary.
*/
function ledge_getup_move() {
	//Snap to getup position
	if ((ledge_getup_check_collision && 
		!collision(x + ledge_getup_finish_x * facing, y + ledge_getup_finish_y, [FLAG.solid])) ||
		!ledge_getup_check_collision)
		{
		x += ledge_getup_finish_x * facing;
		y += ledge_getup_finish_y;
		move_out_of_blocks(90);
		}
}
/* Copyright 2023 Springroll Games / Yosi */