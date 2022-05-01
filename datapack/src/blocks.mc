blocks move_on {
	minecraft:white_glazed_terracotta
	minecraft:orange_glazed_terracotta
}

blocks move_through {
	
}

blocks block_movement {
	
}

blocks target_through {
	
}

blocks block_target {
	
}

dir origin_board_a {
	function give {
		give @s white_glazed_terracotta{display:{Name:'{"text":"origin_board_a","italic":false}'}}
	}
	function setblock {
		setblock ~ ~ ~ white_glazed_terracotta
	}
}

dir origin_board_b {
	function give {
		give @s orange_glazed_terracotta{display:{Name:'{"text":"origin_board_b","italic":false}'}}
	}
	function setblock {
		setblock ~ ~ ~ orange_glazed_terracotta
	}
}

