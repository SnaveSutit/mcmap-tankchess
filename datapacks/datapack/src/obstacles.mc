
function remove_obstacle {
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

	execute on passengers run kill @s
	kill @s
}

function place_obstacle_a {
	$function animated_java:$(skin)_obstacle_a/summon
	execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
		tag @s add shape.a
		tag @s add obstacle
	}
	setblock ^ ^ ^ minecraft:black_carpet
}

function place_obstacle_b {
	$function animated_java:$(skin)_obstacle_b/summon
	execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
		tag @s add shape.b
		tag @s add obstacle
	}
	setblock ^ ^ ^ minecraft:black_carpet
	setblock ^ ^ ^1 minecraft:black_carpet
}

function place_obstacle_c {
	$function animated_java:$(skin)_obstacle_c/summon
	execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
		tag @s add shape.c
		tag @s add obstacle
	}
	setblock ^ ^ ^-1 minecraft:black_carpet
	setblock ^ ^ ^ minecraft:black_carpet
	setblock ^ ^ ^1 minecraft:black_carpet
}

function place_obstacle_d {
	$function animated_java:$(skin)_obstacle_d/summon
	execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
		tag @s add shape.d
		tag @s add obstacle
	}
	setblock ^ ^ ^-1 minecraft:black_carpet
	setblock ^ ^ ^ minecraft:black_carpet
	setblock ^-1 ^ ^ minecraft:black_carpet
}

function place_obstacle_d_mirror {
	$function animated_java:$(skin)_obstacle_d_mirror/summon
	execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
		tag @s add shape.d_mirror
		tag @s add obstacle
	}
	setblock ^ ^ ^-1 minecraft:black_carpet
	setblock ^ ^ ^ minecraft:black_carpet
	setblock ^1 ^ ^ minecraft:black_carpet
}

function place_obstacle_e {
	$function animated_java:$(skin)_obstacle_e/summon
	execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
		tag @s add shape.e
		tag @s add obstacle
	}
	setblock ^ ^ ^-1 minecraft:black_carpet
	setblock ^ ^ ^ minecraft:black_carpet
	fill ^-1 ^ ^ ^-1 ^ ^2 minecraft:black_carpet
}

function place_obstacle_e_mirror {
	$function animated_java:$(skin)_obstacle_e_mirror/summon
	execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
		tag @s add shape.e_mirror
		tag @s add obstacle
	}
	setblock ^ ^ ^-1 minecraft:black_carpet
	setblock ^ ^ ^ minecraft:black_carpet
	fill ^1 ^ ^ ^1 ^ ^2 minecraft:black_carpet
}

function place_obstacle_f {
	$function animated_java:$(skin)_obstacle_f/summon
	execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
		tag @s add shape.f
		tag @s add obstacle
	}
	setblock ^ ^ ^-1 minecraft:black_carpet
	fill ^-1 ^ ^ ^ ^ ^1 minecraft:black_carpet
}

function place_obstacle_f_mirror {
	$function animated_java:$(skin)_obstacle_f_mirror/summon
	execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
		tag @s add shape.f_mirror
		tag @s add obstacle
	}
	setblock ^ ^ ^-1 minecraft:black_carpet
	fill ^1 ^ ^ ^ ^ ^1 minecraft:black_carpet
}

function place_obstacle_g {
	$function animated_java:$(skin)_obstacle_g/summon
	execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
		tag @s add shape.g
		tag @s add obstacle
	}
	fill ^ ^ ^-1 ^ ^ ^3 minecraft:black_carpet
	fill ^-1 ^ ^ ^-1 ^ ^1 minecraft:black_carpet
}

function place_obstacle_g_mirror {
	$function animated_java:$(skin)_obstacle_g_mirror/summon
	execute as @e[type=item_display,limit=1,distance=..0.1] at @s run {
		tag @s add shape.g_mirror
		tag @s add obstacle
	}
	fill ^ ^ ^-1 ^ ^ ^3 minecraft:black_carpet
	fill ^1 ^ ^ ^1 ^ ^1 minecraft:black_carpet
}