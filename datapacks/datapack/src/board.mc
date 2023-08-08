import ./const.mcm

function apply_size_changes {
	# Save the last size
	scoreboard players operation board.last.x v = board.x v
	scoreboard players operation board.last.z v = board.z v
	# Apply the new size
	scoreboard players operation board.x v = board.new.x v
	scoreboard players operation board.z v = board.new.z v
}

function build {
	function board:remove_previous
	# Center board in play area
	scoreboard players operation #x v = board.x v
	scoreboard players operation #x v /= 2 v
	# Center x
	execute positioned 0 10 0 run {
		scoreboard players remove #x v 1
		execute if score #x v matches 0 run {
			# Center z
			scoreboard players operation #z v = board.z v
			scoreboard players operation #z v /= 2 v
			{
				scoreboard players remove #z v 1
				execute if score #z v matches 0 run function board:place_checkerboard
				execute if score #z v matches 1.. positioned ~ ~ ~-1 run function $block
			}
		}
		execute if score #x v matches 1.. positioned ~-1 ~ ~ run function $block
	}
}

function place_checkerboard {
	# Loop over z
	scoreboard players operation #z v = board.z v
	{
		scoreboard players operation #x v = board.x v
		# Loop over x
		{
			# eq #a v = (#x v + #z v) % 2
			scoreboard players operation #a v = #x v
			scoreboard players operation #a v += #z v
			scoreboard players operation #a v %= 2 v
			execute if score #a v matches 0 run {
				# particle block_marker granite ~ ~ ~
				function blocks:origin_board_a/setblock
			}
			execute if score #a v matches 1 run {
				# particle block_marker diorite ~ ~ ~
				function blocks:origin_board_b/setblock
			}

			scoreboard players remove #x v 1
			execute if score #x v matches 1.. positioned ~1 ~ ~ run function $block
		}
		scoreboard players remove #z v 1
		execute if score #z v matches 1.. positioned ~ ~ ~1 run function $block
	}
}

function remove_previous {
	# Center board in play area
	scoreboard players operation #x v = board.last.x v
	scoreboard players operation #x v /= 2 v
	# Center x
	execute positioned 0 10 0 run {
		scoreboard players remove #x v 1
		execute if score #x v matches 0 run {
			# Center z
			scoreboard players operation #z v = board.last.z v
			scoreboard players operation #z v /= 2 v
			{
				scoreboard players remove #z v 1
				execute if score #z v matches 0 run function board:remove_checkerboard
				execute if score #z v matches 1.. positioned ~ ~ ~-1 run function $block
			}
		}
		execute if score #x v matches 1.. positioned ~-1 ~ ~ run function $block
	}
}

function remove_checkerboard {
	# Loop over z
	scoreboard players operation #z v = board.last.z v
	{
		scoreboard players operation #x v = board.last.x v
		# Loop over x
		{
			setblock ~ ~ ~ air

			scoreboard players remove #x v 1
			execute if score #x v matches 1.. positioned ~1 ~ ~ run function $block
		}
		scoreboard players remove #z v 1
		execute if score #z v matches 1.. positioned ~ ~ ~1 run function $block
	}
}

