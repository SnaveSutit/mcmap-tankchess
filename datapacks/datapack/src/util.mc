
function align_rotation_cardinal {
	# Aligns the rotation of the entity to the nearest cardinal direction. (N S E W)
	execute if entity @s[y_rotation=-45..45] run tp @s ~ ~ ~ 0 ~
	execute if entity @s[y_rotation=45..135] run tp @s ~ ~ ~ 90 ~
	execute if entity @s[y_rotation=135..225] run tp @s ~ ~ ~ 180 ~
	execute if entity @s[y_rotation=225..315] run tp @s ~ ~ ~ 270 ~
	execute if entity @s[y_rotation=315..405] run tp @s ~ ~ ~ 0 ~
}

function set_teleportation_duration {
	$execute on passengers run data modify entity @s teleport_duration set value $(value)
	$data modify entity @s teleport_duration set value $(value)
}

function kill_stack {
	execute on passengers run kill @s
	kill @s
}