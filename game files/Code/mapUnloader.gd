extends Area

export var mapId = []

func _on_mapUnloader_body_entered(body):
	if body.is_in_group("Player"):
		for id in range(mapId.size()):
			Globals.maps.unloadMapSection(mapId[id])
