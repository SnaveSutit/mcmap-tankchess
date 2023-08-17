
function clear_loaded_map {
	data modify storage func:input args set value {skin: 'original', ghost: 'false'}
	data modify storage func:input args.skin set from storage settings:ram skin
	execute as @e[tag=obstacle,x=11,y=11,z=-10, dx=-21,dy=8,dz=21] at @s run function obstacles:remove_obstacle with storage func:input args
}
