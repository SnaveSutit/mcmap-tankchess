LOOP(config.tc.Vehicle.all, v) {
	dir <%v.name%> {
		dir on_summon {
			functions as_root {
				vehicles:on_summon_<%v.name%>
			}
		}
	}
}
