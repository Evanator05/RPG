extends Spatial

var player = preload("res://Object/Player.tscn")

func _ready():
	Globals.maps = $Maps
	Globals.loadPlayer(Globals.playerName)
	spawnPlayer()

func spawnPlayer():
	var playerInst = player.instance()
	playerInst.global_transform.origin = Globals.playerSpawnPos
	playerInst.rotation_degrees = Globals.playerSpawnRot
	add_child(playerInst)
	Globals.maps.loadMapSections(Globals.playerMapChunks)
