function load {
	scoreboard players add .activeSkin.id v 0
	scoreboard players add .activeSkin.cmdOffset v 0
}

LOOP(config.tc.Skin.all, skin) {
	dir <%skin.name%> {
		function apply {
			scoreboard players set .activeSkin.id v <%skin.id%>
			scoreboard players set .activeSkin.cmdOffset v <%skin.customModelDataOffset%>
			tellraw @a {"text":"Applied skin '<%skin.name%>'"}
		}
	}
}
