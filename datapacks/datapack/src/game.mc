
!config.dev {
	function load {
		function scoreboard:init

		tellraw @a ["", {"text":"Reloaded!"}]
		execute as @a at @s run playsound block.note_block.bell master @s ~ ~ ~ 10 1
	}
}

function reset {
	
}

dir holding {
	predicate custom_item {
		"condition": "minecraft:entity_properties",
		"entity": "this",
		"predicate": {
			"equipment": {
				"mainhand": {
					"nbt": "{isCustomItem:true}"
				}
			}
		}
	}
}