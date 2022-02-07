extends Area

export var mapId = 1

func _on_mapUnloader_body_entered(body):
	if body.is_in_group("Player"):
		Globals.maps.unloadMapSection(mapId)
