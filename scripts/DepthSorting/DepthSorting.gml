// Changes the layer of objects interacting with the bottom of the object's hitbox to create a sense of depth.
function DepthSorting(object_type) {
	if (object_type == "ember spawner") {
		if (obj_Player.y > id.bbox_bottom - 10) {
			depth = obj_Player.depth + 1;
		}
		else {
			depth = obj_Player.depth - 1;
		}
	}
	if (object_type == "tree") {
		//Depth Sort With Player
		if (obj_Player.y > bbox_bottom - 10) {
			depth = obj_Player.depth + 2;
		}
		else {
			depth = obj_Player.depth - 1;
		}
	}
}
