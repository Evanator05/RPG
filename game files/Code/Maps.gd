extends Spatial

func loadMapSections(mapIds):
	for id in mapIds:
		loadMapSection(id)

func unloadMapSections(mapIds):
	for id in mapIds:
		unloadMapSection(id)

func loadMapSection(mapId):
	if get_node_or_null(Globals.mapIds[mapId]) == null:
		var map = load("res://Scenes/Areas/" + Globals.mapIds[mapId] + ".tscn")
		var mapinst = map.instance()
		add_child(mapinst)

func unloadMapSection(mapId):
	if get_node_or_null(Globals.mapIds[mapId]) != null:
		get_node(Globals.mapIds[mapId]).queue_free()
