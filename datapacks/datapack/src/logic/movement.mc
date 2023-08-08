import ../dev.mcm

function scan_as_vehicle {
	dev scoreboard players set .movecount i 0
	dev scoreboard players set .targetcount i 0

	function vehicles:collect_this_context
	LOOP(config.tc.Vehicle.all,v) {
		execute if score .this.type v matches <%v.id%> run function logic:movement/<%v.name%>/scan/start
	}
}

LOOP(config.tc.Vehicle.all, v) {
	dir <%v.name%> {
		dir scan {
			function start {
				\# ID: <%v.name%> | Speed: <%v.speed%>

				tag @s remove vehicle
				function logic:movement/<%v.name%>/scan/branch0
				tag @s add vehicle
				function logic:movement/<%v.name%>/scan/cleanup
				# tellraw @a ["items: ", {"score":{"name":".count","objective":"i"}}]
			}

			<%% config.tags = new Set() %%>
			LOOP(config.generateMoveTree(v), item) {
				<%% config.tags.add(`x${item.local.x}.z${item.local.z}.r${item.local.r}`) %%>

				!IF(item.type === 'branch') {
					function branch<%item.id%> {
						dev particle minecraft:wax_on ^ ^.25 ^.2 0 0 0 0 0 force @a

						# Don't scan this location for targets if it's already been scanned
						execute unless entity @s[tag=x<%item.local.x%>.z<%item.local.z%>.r<%item.local.r%>] run {
							dev scoreboard players add .movecount i 1
							tag @s add x<%item.local.x%>.z<%item.local.z%>.r<%item.local.r%>
							dev particle minecraft:wax_on ^ ^1.0 ^.2 0 0 0 0 0 force @a
							function logic:targeting/scan_as_vehicle
						}

						!IF(item.items.left) {
							execute rotated ~-45 0 run function logic:movement/<%v.name%>/scan/<%item.items.left.type%><%item.items.left.id%>
						}
						(
							execute positioned ^ ^ ^1 align xyz positioned ~.5 ~ ~.5
							if block ~ ~ ~ #minecraft:air
							run function logic:movement/<%v.name%>/scan/<%item.items.straight.type%><%item.items.straight.id%>
						)
						!IF(item.items.right) {
							execute rotated ~45 0 run function logic:movement/<%v.name%>/scan/<%item.items.right.type%><%item.items.right.id%>
						}
					}
				}
				!IF(item.type === 'leaf') {
					function leaf<%item.id%> {
						dev particle minecraft:wax_off ^ ^.35 ^.2 0 0 0 0 0 force @a
						# Don't scan this location for targets if it's already been scanned
						execute if entity @s[tag=x<%item.local.x%>.z<%item.local.z%>.r<%item.local.r%>] run return 0

						dev scoreboard players add .movecount i 1
						tag @s add x<%item.local.x%>.z<%item.local.z%>.r<%item.local.r%>
						dev particle minecraft:wax_off ^ ^1.1 ^.2 0 0 0 0 0 force @a
						function logic:targeting/scan_as_vehicle
					}
				}
			}

			function cleanup {
				LOOP(Array.from(config.tags), v) {
					tag @s remove <%v%>
				}
			}
		}
	}
}