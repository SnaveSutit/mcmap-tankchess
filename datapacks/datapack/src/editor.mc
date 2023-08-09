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

		execute (if predicate game:holding/custom_item) {
			scoreboard players set #distance v 500
			{
				execute unless block ~ ~ ~ #minecraft:air run {
					scoreboard players set #distance v 0
					execute unless entity 0-0-0-0-0 run {
						# say summon
						execute align xyz positioned ~.5 ~1 ~.5 run summon marker ~ ~ ~ {Tags:['raycast_marker'],UUID:[I;0,0,0,0]}
					}
					execute if entity 0-0-0-0-0 run {
						execute align xyz positioned ~.5 ~1 ~.5 run tp 0-0-0-0-0 ~ ~ ~ ~ ~
					}
				}
				scoreboard players remove #distance v 1
				execute positioned ^ ^ ^0.1 if score #distance v matches 1.. run function $block
			}
		} else execute (if entity 0-0-0-0-0) {
			# say kill
			kill 0-0-0-0-0
		}

		LOOP(config.obstacles,i) {
			execute (if predicate editor:holding/place_obstacle_<%i%>) {
				kill @e[tag=ghost,tag=!ghost_<%i%>]
				execute as 0-0-0-0-0 at @s rotated ~ 0 run {
					execute (unless entity @e[type=item_display,tag=ghost_<%i%>] positioned ~ -10 ~) {
						function obstacles:summon_obstacle_<%i%> with storage settings:ram
						execute as @e[type=item_display,distance=..0.01,limit=1] run {
							tag @s add ghost_<%i%>
							tag @s add ghost
							function util:align_rotation_cardinal
							function util:set_teleportation_duration {value:'1'}
						}
					} else execute (as @e[type=item_display,tag=ghost_<%i%>]) {
						tp @s ~ ~.25 ~ ~ ~
						execute at @s run function util:align_rotation_cardinal
					}
				}
				execute if score @s click matches 1.. run {
					say Place Obstacle <%i%>
					execute at @e[type=item_display,tag=ghost_<%i%>,limit=1] rotated ~ 0 positioned ~ ~-0.25 ~ run function obstacles:summon_obstacle_<%i%> with storage settings:ram
				}
			} else execute (as @e[type=item_display,tag=ghost_<%i%>]) {
				function util:kill_stack
			}
		}
	}
	scoreboard players set @a click 0
}

function give_editor_tools {
	LOOP(config.obstacles, i) {
		item replace entity @s container.<%config.obstacles.indexOf(i)%> with editor:place_obstacle_<%i%> 1
	}
}

dir holding {
	LOOP(config.obstacles, i) {
		predicate place_obstacle_<%i%> {
			"condition": "minecraft:entity_properties",
			"entity": "this",
			"predicate": {
				"equipment": {
					"mainhand": {
						"items": [
							"minecraft:carrot_on_a_stick"
						],
						"nbt": "{customItemId:'editor:place_obstacle_<%i%>'}"
					}
				}
			}
		}
	}
}
