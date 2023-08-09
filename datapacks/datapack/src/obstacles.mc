
function remove_obstacle {
	execute on passengers run kill @s
	kill @s

	function obstacles:set_obstacle_blocks
}

function set_obstacle_blocks {
	execute if entity @s[tag=shape.a] at @s run {
		setblock ^ ^ ^ minecraft:black_carpet
	}
	execute if entity @s[tag=shape.b] at @s run {
		fill ^ ^ ^ ^ ^ ^1 minecraft:black_carpet
	}
	execute if entity @s[tag=shape.c] at @s run {
		fill ^ ^ ^-1 ^ ^ ^ minecraft:black_carpet
		setblock ^ ^ ^1 minecraft:black_carpet
	}
	execute if entity @s[tag=shape.d] at @s run {
		fill ^ ^ ^-1 ^ ^ ^ minecraft:black_carpet
		setblock ^-1 ^ ^ minecraft:black_carpet
	}
	execute if entity @s[tag=shape.d_mirror] at @s run {
		fill ^ ^ ^-1 ^ ^ ^ minecraft:black_carpet
		setblock ^1 ^ ^ minecraft:black_carpet
	}
	execute if entity @s[tag=shape.e] at @s run {
		setblock ^ ^ ^-1 minecraft:black_carpet
		setblock ^ ^ ^ minecraft:black_carpet
		fill ^-1 ^ ^ ^-1 ^ ^2 minecraft:black_carpet
	}
	execute if entity @s[tag=shape.e_mirror] at @s run {
		setblock ^ ^ ^-1 minecraft:black_carpet
		setblock ^ ^ ^ minecraft:black_carpet
		fill ^1 ^ ^ ^1 ^ ^2 minecraft:black_carpet
	}
	execute if entity @s[tag=shape.f] at @s run {
		setblock ^ ^ ^-1 minecraft:black_carpet
		fill ^-1 ^ ^ ^ ^ ^1 minecraft:black_carpet
	}
	execute if entity @s[tag=shape.f_mirror] at @s run {
		setblock ^ ^ ^-1 minecraft:black_carpet
		fill ^1 ^ ^ ^ ^ ^1 minecraft:black_carpet
	}
	execute if entity @s[tag=shape.g] at @s run {
		fill ^ ^ ^-1 ^ ^ ^3 minecraft:black_carpet
		fill ^-1 ^ ^ ^-1 ^ ^1 minecraft:black_carpet
	}
	execute if entity @s[tag=shape.g_mirror] at @s run {
		fill ^ ^ ^-1 ^ ^ ^3 minecraft:black_carpet
		fill ^1 ^ ^ ^1 ^ ^1 minecraft:black_carpet
	}
}

function remove_obstacle_blocks {
	execute if entity @s[tag=shape.a] at @s run {
		setblock ^ ^ ^ minecraft:air
	}
	execute if entity @s[tag=shape.b] at @s run {
		fill ^ ^ ^ ^ ^ ^1 minecraft:air
	}
	execute if entity @s[tag=shape.c] at @s run {
		fill ^ ^ ^-1 ^ ^ ^ minecraft:air
		setblock ^ ^ ^1 minecraft:air
	}
	execute if entity @s[tag=shape.d] at @s run {
		fill ^ ^ ^-1 ^ ^ ^ minecraft:air
		setblock ^-1 ^ ^ minecraft:air
	}
	execute if entity @s[tag=shape.d_mirror] at @s run {
		fill ^ ^ ^-1 ^ ^ ^ minecraft:air
		setblock ^1 ^ ^ minecraft:air
	}
	execute if entity @s[tag=shape.e] at @s run {
		setblock ^ ^ ^-1 minecraft:air
		setblock ^ ^ ^ minecraft:air
		fill ^-1 ^ ^ ^-1 ^ ^2 minecraft:air
	}
	execute if entity @s[tag=shape.e_mirror] at @s run {
		setblock ^ ^ ^-1 minecraft:air
		setblock ^ ^ ^ minecraft:air
		fill ^1 ^ ^ ^1 ^ ^2 minecraft:air
	}
	execute if entity @s[tag=shape.f] at @s run {
		setblock ^ ^ ^-1 minecraft:air
		fill ^-1 ^ ^ ^ ^ ^1 minecraft:air
	}
	execute if entity @s[tag=shape.f_mirror] at @s run {
		setblock ^ ^ ^-1 minecraft:air
		fill ^1 ^ ^ ^ ^ ^1 minecraft:air
	}
	execute if entity @s[tag=shape.g] at @s run {
		fill ^ ^ ^-1 ^ ^ ^3 minecraft:air
		fill ^-1 ^ ^ ^-1 ^ ^1 minecraft:air
	}
	execute if entity @s[tag=shape.g_mirror] at @s run {
		fill ^ ^ ^-1 ^ ^ ^3 minecraft:air
		fill ^1 ^ ^ ^1 ^ ^1 minecraft:air
	}
}

LOOP(config.obstacles,i) {
	function summon_obstacle_<%i%> {
		$function animated_java:$(skin)_obstacle_<%i%>/summon
		execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
			tag @s add shape.<%i%>
			tag @s add obstacle
		}
	}
}
