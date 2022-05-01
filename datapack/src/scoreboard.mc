import ./const.mcm

function load {
	scoreboard objectives add i dummy
	scoreboard objectives add v dummy

	#> Vehicle Variables
	scoreboard objectives add V.id dummy
	scoreboard objectives add V.type dummy
	scoreboard objectives add V.move.type dummy
	scoreboard objectives add V.move.speed dummy
	scoreboard objectives add V.gun.type dummy
	scoreboard objectives add V.gun.power dummy
	scoreboard objectives add V.armor.front dummy
	scoreboard objectives add V.armor.side dummy
	scoreboard objectives add V.armor.back dummy

	#> Board Variables
	scoreboard players add board.x v 0
	scoreboard players add board.z v 0
	scoreboard players add board.new.x v 0
	scoreboard players add board.new.z v 0
	scoreboard players add board.last.x v 0
	scoreboard players add board.last.z v 0

	#> Constants
	const 2
}