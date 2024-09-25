extends Area

export var mapId = []

func _on_mapLoader_body_entered(body):
	if body.is_in_group("Player"):
		for id in range(mapId.size()):
			Globals.maps.loadMapSection(mapId[id])
