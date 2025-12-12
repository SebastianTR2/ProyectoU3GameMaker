// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlaceMeeting3D(newX, newY, solid){
	var block = instance_place(newX, newY, solid);
	
	//Update depth
	if (block && block.z < z) {
		depth = -bbox_bottom;
	}
	
	if (block == noone || (z <= block.z || zHeight >= block.z)) {
		return false;
	}
	
	return true;
}

function TileMeeting3D(newX, newY, tiles) {
	for(var i = 0; i < array_length(tiles); ++i) {
		var tileZ = (i + 1) * -16;
		
		var collision = tilemap_get_at_pixel(tiles[i], newX, newY + tileZ);
		
		//Player depth
		var bottomCollision = tilemap_get_at_pixel(tiles[i], o_player.x, bbox_bottom + ySpeed);
		var leftCollision = tilemap_get_at_pixel(tiles[i], bbox_left, bbox_bottom + ySpeed);
		var rightCollision = tilemap_get_at_pixel(tiles[i], bbox_right, bbox_bottom + ySpeed);
		if ((bottomCollision || leftCollision || rightCollision) && z - 1 >= tileZ) {
			depth = (i + 1) * 100;
		}
		
		
		if (collision > 0 && (z - 1 >= tileZ)) {
			return true;
		}
	}
	
	return false;
}