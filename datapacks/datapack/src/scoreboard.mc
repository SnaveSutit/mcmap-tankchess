import ./const.mcm

function init {
	scoreboard objectives add i dummy
	scoreboard objectives add v dummy
	scoreboard objectives add click minecraft.used:minecraft.carrot_on_a_stick

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
	scoreboard players set true v 1
	scoreboard players set false v 0
	const 2
}