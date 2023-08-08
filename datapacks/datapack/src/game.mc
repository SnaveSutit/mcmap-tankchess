
!config.dev {
	function load {
		function scoreboard:init

		tellraw @a ["", {"text":"Reloaded!"}]
		execute as @a at @s run playsound block.note_block.bell master @s ~ ~ ~ 10 1
	}
}

function reset {
	
}