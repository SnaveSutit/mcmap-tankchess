
function clear_loaded_map {
	execute as @e[tag=obstacle] at @s run function obstacles:remove_obstacle with storage settings:ram
	# fill -9 11 -9 10 18 10 air
}
