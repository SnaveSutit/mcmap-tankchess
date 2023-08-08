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

function tick {
	execute if score .editor_active v matches 0 run return 0

	execute as @a[tag=editor] run {
		execute if predicate editor:holding/place_obstacle_a run {
			execute if score @s click matches 1.. at @s anchored eyes positioned ^ ^ ^ run {
				say Clicked A!
				# function raycast:cast {max_steps: 100, step_size: '0.1', function: 'editor:test'}
			}
		}
		# execute if predicate editor:holding/place_obstacle_b run {
		# 	execute if score @s click matches 1.. at @s anchored eyes positioned ^ ^ ^ run {
		# 		say Clicked B!
		# 	}
		# }
	}
	scoreboard players set @a click 0
}

function test {
	say hi
	particle end_rod ^ ^ ^-0.1 0 0 0 0 1 force
}

function give_editor_tools {
	item replace entity @s hotbar.0 with editor:place_obstacle_a 1
	item replace entity @s hotbar.1 with editor:place_obstacle_b 1
}

dir holding {
	predicate place_obstacle_a {
		"condition": "minecraft:entity_properties",
		"entity": "this",
		"predicate": {
			"equipment": {
				"mainhand": {
					"items": [
						"minecraft:carrot_on_a_stick"
					],
					"nbt": "{customItemId:'editor:place_obstacle_a'}"
				}
			}
		}
	}
	predicate place_obstacle_b {
		"condition": "minecraft:entity_properties",
		"entity": "this",
		"predicate": {
			"equipment": {
				"mainhand": {
					"items": [
						"minecraft:carrot_on_a_stick"
					],
					"nbt": "{customItemId:'editor:place_obstacle_b'}"
				}
			}
		}
	}
}
