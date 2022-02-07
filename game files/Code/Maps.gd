extends Spatial

var maps = ["TheHub", "TheForest", "TheSewers"]

func loadMapSections(mapIds):
	for id in mapIds:
		loadMapSection(id)

func unloadMapSections(mapIds):
	for id in mapIds:
		unloadMapSection(id)

func loadMapSection(mapId):
	if get_node_or_null(maps[mapId]) == null:
		var map = load("res://Scenes/" + maps[mapId] + ".tscn")
		var mapinst = map.instance()
		add_child(mapinst)

func unloadMapSection(mapId):
	if get_node_or_null(maps[mapId]) != null:
		get_node(maps[mapId]).queue_free()
