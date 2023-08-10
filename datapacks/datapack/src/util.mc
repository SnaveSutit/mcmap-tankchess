
function align_rotation_cardinal {
	# Aligns the rotation of the entity to the nearest cardinal direction. (N S E W)
	execute if entity @s[y_rotation=-45..45] run tp @s ~ ~ ~ 0 ~
	execute if entity @s[y_rotation=45..135] run tp @s ~ ~ ~ 90 ~
	execute if entity @s[y_rotation=135..225] run tp @s ~ ~ ~ 180 ~
	execute if entity @s[y_rotation=225..315] run tp @s ~ ~ ~ 270 ~
	execute if entity @s[y_rotation=315..405] run tp @s ~ ~ ~ 0 ~
}

function align_rotation_cardinal8 {
	# Aligns the rotation of the entity to the nearest cardinal direction. (N S E W NE SE SW NW)
	execute if entity @s[y_rotation=-22.5..22.5] run tp @s ~ ~ ~ 0 ~
	execute if entity @s[y_rotation=22.5..67.5] run tp @s ~ ~ ~ 45 ~
	execute if entity @s[y_rotation=67.5..112.5] run tp @s ~ ~ ~ 90 ~
	execute if entity @s[y_rotation=112.5..157.5] run tp @s ~ ~ ~ 135 ~
	execute if entity @s[y_rotation=157.5..202.5] run tp @s ~ ~ ~ 180 ~
	execute if entity @s[y_rotation=202.5..247.5] run tp @s ~ ~ ~ 225 ~
	execute if entity @s[y_rotation=247.5..292.5] run tp @s ~ ~ ~ 270 ~
	execute if entity @s[y_rotation=292.5..337.5] run tp @s ~ ~ ~ 315 ~
	execute if entity @s[y_rotation=337.5..382.5] run tp @s ~ ~ ~ 0 ~
}

function set_teleportation_duration {
	$execute on passengers run data modify entity @s teleport_duration set value $(value)
	$data modify entity @s teleport_duration set value $(value)
}

function kill_stack {
	execute on passengers run kill @s
	kill @s
}

function place_structure_by_entity_rotation {
	$execute if entity @s[y_rotation=-45..45] run place template $(structure) ~ ~ ~ none $(mirror)
	$execute if entity @s[y_rotation=45..135] run place template $(structure) ~ ~ ~ clockwise_90 $(mirror)
	$execute if entity @s[y_rotation=135..225] run place template $(structure) ~ ~ ~ 180 $(mirror)
	$execute if entity @s[y_rotation=225..315] run place template $(structure) ~ ~ ~ counterclockwise_90 $(mirror)
	$execute if entity @s[y_rotation=315..405] run place template $(structure) ~ ~ ~ none $(mirror)
}