import ./tellraw.mcm
import ./items.mcm

function load {
	scoreboard players add .editor_active v 0
}

function start_editing {
	scoreboard players set .editor_active v 1
	tag @s add editor

	tellraw @a editor:activate
}

function stop_editing {
	scoreboard players set .editor_active v 0
	tag @a remove editor

	tellraw @a editor:deactivate
}

function clear_loaded_map {
	data modify storage func:input args set value {skin: 'original', ghost: 'false'}
	data modify storage func:input args.skin set from storage settings:ram skin
	execute as @e[tag=obstacle,x=990,y=11,z=-10, dx=21,dy=10,dz=21] at @s run function obstacles:remove_obstacle with storage func:input args
}

function tick {
	execute if score .editor_active v matches 0 run return 0

	execute as @a[tag=editor] at @s anchored eyes positioned ^ ^ ^ run {
		tag @s add this.player
		execute (if predicate game:holding/custom_item) {
			scoreboard players set #distance v 250
			{
				execute unless block ~ ~ ~ #minecraft:air run {
					name interaction_raycast_hit_block
					scoreboard players set #distance v 0
					execute unless entity 0-0-0-0-0 run {
						# say summon
						execute align xyz positioned ~.5 ~1 ~.5 run summon marker ~ ~ ~ {Tags:['raycast_marker'],UUID:[I;0,0,0,0]}
					}
					execute if entity 0-0-0-0-0 run {
						execute align xyz positioned ~.5 ~1 ~.5 run tp 0-0-0-0-0 ~ ~ ~ ~ ~
					}
					execute as 0-0-0-0-0 at @s positioned ~ 11 ~ unless entity @s[distance=..0.1] run function editor:kill_ghost
					execute as 0-0-0-0-0 at @s unless block ~ 10 ~ #blocks:board run function editor:kill_ghost
				}
				scoreboard players remove #distance v 1
				execute positioned ^ ^ ^0.1 if score #distance v matches 1.. run function $block
			}
			execute if score #distance v matches 0 run {
				name kill_ghost
				kill 0-0-0-0-0
				kill @e[tag=ghost]
			}
		} else execute (if entity 0-0-0-0-0) {
			# say kill
			kill 0-0-0-0-0
		}

		execute as @e[tag=collided_entity,limit=1] run {
			data modify entity @s Glowing set value 0b
		}
		execute if predicate editor:holding/remove_piece run {
			execute at 0-0-0-0-0 run {
				function editor:check_for_point_collision
				execute if score #return v matches 1 run {
					scoreboard players operation #click v = @s click
					execute as @e[tag=collided_entity,limit=1] run {
						data merge entity @s {Glowing: 1b, glow_color_override: 16711680}
						execute if score #click v matches 1.. run {
							function editor:remove_piece
							execute as @a[tag=this.player] at @s run function sounds:remove_piece
						}
					}
				}
			}
		}

		LOOP(config.tc.Vehicle.all,v) {
			execute (if predicate editor:holding/place_vehicle_<%v.name%>) {
				kill @e[tag=ghost,tag=!ghost_<%v.name%>]
				execute as 0-0-0-0-0 at @s rotated ~ 0 run {
					execute (unless entity @e[type=item_display,tag=ghost_<%v.name%>] positioned ~ 2000 ~) {
						function vehicles:summon_<%v.name%> with storage settings:ram
						execute as @e[type=item_display,distance=..0.01,limit=1] run {
							tag @s add ghost_<%v.name%>
							tag @s add ghost
							data merge entity @s {Glowing: 1b, glow_color_override: 0}
							function util:align_rotation_cardinal
							function util:set_teleportation_duration {value:'1'}
						}
					} else execute (as @e[type=item_display,tag=ghost_<%v.name%>]) {
						tp @s ~ ~.25 ~ ~ ~
						execute at @s run function util:align_rotation_cardinal8
					}
				}
				execute if score @s click matches 1.. run {
					execute at @e[type=item_display,tag=ghost_<%v.name%>,limit=1] run {
						execute as @e[type=item_display,tag=ghost_<%v.name%>,limit=1] run {
							function editor:check_for_obstacle_collision {command:'setblock ~ 5 ~ minecraft:piston[facing=up]'}
							execute if score #return v matches 0 run function obstacles:set_obstacle_path_blocks
						}
						execute if score #return v matches 0 run {
							# say Placed Obstacle <%v.name%>
							execute rotated ~ 0 positioned ~ ~-0.25 ~ run function vehicles:summon_<%v.name%> with storage settings:ram
							execute as @a[tag=this.player] at @s run function sounds:place_piece
						}
						execute if score #return v matches 1 as @a[tag=this.player] at @s run function sounds:error
					}
				}
			} else execute (as @e[type=item_display,tag=ghost_<%v.name%>]) {
				function util:kill_stack
			}
		}

		LOOP(config.obstacles,i) {
			execute (if predicate editor:holding/place_obstacle_<%i%>) {
				kill @e[tag=ghost,tag=!ghost_<%i%>]
				execute as 0-0-0-0-0 at @s rotated ~ 0 run {
					execute (unless entity @e[type=item_display,tag=ghost_<%i%>] positioned ~ 2000 ~) {
						function obstacles:summon_obstacle_<%i%> with storage settings:ram
						execute as @e[type=item_display,distance=..0.01,limit=1] run {
							tag @s add ghost_<%i%>
							tag @s add ghost
							data merge entity @s {Glowing: 1b, glow_color_override: 0}
							function util:align_rotation_cardinal
							function util:set_teleportation_duration {value:'1'}
						}
					} else execute (as @e[type=item_display,tag=ghost_<%i%>]) {
						tp @s ~ ~.25 ~ ~ ~
						execute at @s run function util:align_rotation_cardinal
					}
				}
				execute if score @s click matches 1.. run {
					execute at @e[type=item_display,tag=ghost_<%i%>,limit=1] run {
						execute as @e[type=item_display,tag=ghost_<%i%>,limit=1] run {
							function editor:check_for_obstacle_collision {command:'function obstacles:set_obstacle_path_blocks'}
							execute if score #return v matches 0 run function obstacles:set_obstacle_path_blocks
						}
						execute if score #return v matches 0 run {
							# say Placed Obstacle <%i%>
							execute rotated ~ 0 positioned ~ ~-0.25 ~ run function obstacles:summon_obstacle_<%i%> with storage settings:ram
							execute as @a[tag=this.player] at @s run function sounds:place_piece
						}
						execute if score #return v matches 1 as @a[tag=this.player] at @s run function sounds:error
					}
				}
			} else execute (as @e[type=item_display,tag=ghost_<%i%>]) {
				function util:kill_stack
			}
		}
		tag @s remove this.player
	}
	scoreboard players set @a click 0
}

function remove_piece {
	execute if entity @s[tag=obstacle] run {
		function obstacles:remove_obstacle_path_blocks
		function obstacles:remove_obstacle
	}
	execute if entity @s[tag=vehicle] run function util:kill_stack
}

function check_for_obstacle_collision {
	scoreboard players set #return v 0

	execute store result score #board_count v run clone 990 5 -10 1011 5 11 990 2 -10 filtered minecraft:piston move
	$$(command)
	execute store result score #path_count v run clone 990 5 -10 1011 5 11 990 5 -10 filtered minecraft:piston move
	clone 990 2 -10 1011 2 11 990 5 -10 filtered minecraft:piston
	execute store result score #merged_count v run clone 990 5 -10 1011 5 11 990 5 -10 filtered minecraft:piston move

	scoreboard players operation #expected_count v = #path_count v
	scoreboard players operation #expected_count v += #board_count v
	execute unless score #merged_count v = #expected_count v run scoreboard players set #return v 1

	clone 990 2 -10 1011 2 11 990 5 -10 replace move
}

function check_for_point_collision {
	scoreboard players set #return v 0
	tag @e remove collided_entity
	execute positioned ~ 5 ~ run {
		execute if block ~ ~ ~ minecraft:piston[facing=up] run {
			scoreboard players set #return v 1
			execute positioned ~ 11 ~ as @e[type=!player,distance=..0.01,limit=1] run tag @s add collided_entity
		}
		execute if block ~ ~ ~ minecraft:piston[facing=west] positioned ~-1 ~ ~ run function $block
		execute if block ~ ~ ~ minecraft:piston[facing=east] positioned ~1 ~ ~ run function $block
		execute if block ~ ~ ~ minecraft:piston[facing=north] positioned ~ ~ ~-1 run function $block
		execute if block ~ ~ ~ minecraft:piston[facing=south] positioned ~ ~ ~1 run function $block
	}
	# return run scoreboard players get #return v
}

function set_editor_tools_obstacles {
	clear @s

	item replace entity @s container.0 with editor:place_obstacle_a 1
	item replace entity @s container.1 with editor:place_obstacle_b 1
	item replace entity @s container.2 with editor:place_obstacle_c 1
	item replace entity @s container.3 with editor:place_obstacle_d 1
	item replace entity @s container.4 with editor:place_obstacle_e 1
	item replace entity @s container.31 with editor:place_obstacle_e_mirror 1
	item replace entity @s container.5 with editor:place_obstacle_f 1
	item replace entity @s container.32 with editor:place_obstacle_f_mirror 1
	item replace entity @s container.6 with editor:place_obstacle_g 1
	item replace entity @s container.33 with editor:place_obstacle_g_mirror 1

	item replace entity @s container.8 with editor:remove_piece 1
}

function set_editor_tools_vehicles {
	clear @s

	item replace entity @s container.0 with editor:place_vehicle_lv 1
}

dir holding {
	LOOP(Object.entries(config.itemMap.editor), i) {
		predicate <%i[0]%> {
			"condition": "minecraft:entity_properties",
			"entity": "this",
			"predicate": {
				"equipment": {
					"mainhand": {
						"items": [
							"minecraft:carrot_on_a_stick"
						],
						"nbt": "{customItemId:'editor:<%i[0]%>'}"
					}
				}
			}
		}
	}
}
