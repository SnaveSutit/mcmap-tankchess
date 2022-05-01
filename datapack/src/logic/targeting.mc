import ../dev.mcm

# Requires this context
function scan_as_vehicle {
	LOOP(config.tc.GunType.all, v) {
		execute if score .this.gun.type v matches <%v.id%> run function logic:targeting/<%v.name%>/scan/start
	}
}

dir generic {
	dir scan {

		function start {
			scoreboard players set .loop v 0
			function logic:targeting/generic/scan/recurse
		}

		function recurse {
			# Run logic for targeted vehicles/objects that are in range
			execute if score .loop v >= .min_distance v run {
				execute if entity @e[type=area_effect_cloud,tag=vehicle,distance=..0.25,limit=1] run say hehe pewpew
				# dev particle minecraft:dust 1 0 0 1 ~ ~.1 ~ 0 -10 0 10 0 force
			}

			dev scoreboard players add .targetcount i 1

			scoreboard players add .loop v 1
			(
				execute if score .loop v <= .max_distance v
				positioned ^ ^ ^1 align xyz positioned ~.5 ~ ~.5
				if block ~ ~ ~ #blocks:shoot_through
				run function $block
			)
		}

	}
}

dir turret {
	dir scan {
		# Requires this context
		function start {
			scoreboard players set .min_distance v 2
			scoreboard players set .max_distance v 20

			execute rotated ~-45 0 run function logic:targeting/generic/scan/start
			function logic:targeting/generic/scan/start
			execute rotated ~45 0 run function logic:targeting/generic/scan/start
		}
	}
}

dir fixed {
	dir scan {
		# Requires this context
		function start {
			scoreboard players set .min_distance v 2
			scoreboard players set .max_distance v 20
			function logic:targeting/generic/scan/start
		}
	}
}
