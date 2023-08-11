function load {
	data modify storage vehicles:ram name.playerNumber set value '{"font":"tankchess:player_numbers","score":{"name":"#this.player_number","objective":"value"}}'
	data modify storage vehicles:ram name.tankIcon set value '{"font":"tankchess:vehicle_icons","score":{"name":"@s","objective":"V.type"}}'
}

LOOP(config.tc.Vehicle.all, v) {
	function summon_<%v.name%> {
		$execute align xyz positioned ~.5 ~ ~.5 run function animated_java:$(skin)_<%v.name%>/summon
		$execute align xyz positioned ~.5 ~ ~.5 as @e[type=item_display,tag=aj.$(skin)_<%v.name%>.root,distance=..0.01,limit=1] run function vehicles:$(skin)_<%v.name%>/setup_<%v.name%>
	}
	function setup_<%v.name%> {
		execute store result score @s V.id run scoreboard players add #last_id v 1

		tag @s add <%v.name%>
		tag @s add vehicle

		scoreboard players set @s V.type <%v.id%>
		scoreboard players set @s V.speed <%v.speed%>
		scoreboard players set @s V.move.type <%v.movementType.id%>
		scoreboard players set @s V.gun.type <%v.gunType.id%>
		scoreboard players set @s V.gun.power <%v.gunPower%>
		scoreboard players set @s V.armor.front <%v.armor.front%>
		scoreboard players set @s V.armor.side <%v.armor.side%>
		scoreboard players set @s V.armor.back <%v.armor.back%>
	}
}

function collect_this_context {
	scoreboard players operation .this.id v = @s V.id
	scoreboard players operation .this.type v = @s V.type
	scoreboard players operation .this.speed v = @s V.speed
	scoreboard players operation .this.move.type v = @s V.move.type
	scoreboard players operation .this.gun.type v = @s V.gun.type
	scoreboard players operation .this.gun.power v = @s V.gun.power
	scoreboard players operation .this.armor.front v = @s V.armor.front
	scoreboard players operation .this.armor.side v = @s V.armor.side
	scoreboard players operation .this.armor.back v = @s V.armor.back
}

function collect_other_context {
	scoreboard players operation .other.id v = @s V.id
	scoreboard players operation .other.type v = @s V.type
	scoreboard players operation .other.speed v = @s V.speed
	scoreboard players operation .other.move.type v = @s V.move.type
	scoreboard players operation .other.gun.type v = @s V.gun.type
	scoreboard players operation .other.gun.power v = @s V.gun.power
	scoreboard players operation .other.armor.front v = @s V.armor.front
	scoreboard players operation .other.armor.side v = @s V.armor.side
	scoreboard players operation .other.armor.back v = @s V.armor.back
}

function remove_closest {
	execute as @e[type=area_effect_cloud,tag=vehicle,sort=nearest,limit=1] at @s run {
		kill @e[type=armor_stand,tag=vehicle.display,distance=..0.6,sort=nearest,limit=1]
		kill @s
	}
}

# TODO Add player color to nametag
modifier vehicle_name {
	"function": "minecraft:set_name",
	"entity": "this",
	"name": [
		{
			"text": "",
			"italic": false
		},
		{
			"translate": "background",
			"font": "tankchess:nametags"
		},
		"\uF809\uF821",
		[
			"",
			{
				"storage": "vehicles:ram",
				"nbt": "name.playerNumber",
				"interpret": true
			},
			{
				"text": "p",
				"font": "tankchess:player_numbers"
			},
			"\uF801",
			{
				"score": {
					"name": ".this.player_number",
					"objective": "v"
				},
				"font": "tankchess:player_numbers"
			}
		],
		"\uF821",
		{
			"score": {
				"name": "@s",
				"objective": "V.type"
			},
			"font": "tankchess:nametags"
		}
	]
}
