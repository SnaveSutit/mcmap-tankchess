
function cast {
	$scoreboard players set #max_steps v $(max_steps)
	$data modify storage ray:cast data set value {step_size:'$(step_size)',function:'$(function)'}
	function raycast:recurse with storage ray:cast data
}

function recurse {
	particle end_rod ~ ~ ~
	scoreboard players remove #max_steps v 1
	$execute unless block ~ ~ ~ #minecraft:air run function $(function)
	$execute if score #max_steps v matches 1.. positioned ^ ^ ^$(step_size) run function raycast:recurse with storage ray:cast data
}
