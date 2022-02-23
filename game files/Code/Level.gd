extends Spatial

var player = preload("res://Objects/Player.tscn")

func _ready():
	Globals.maps = $Maps
	Save.loadPlayer(Globals.playerName)
	spawnPlayer()

func spawnPlayer():
	var playerInst = player.instance()
	playerInst.global_transform.origin = Globals.playerSpawnPos
	playerInst.rotation_degrees = Globals.playerSpawnRot
	var inventory = Save.loadPlayerInventory(Globals.playerName)
	playerInst.inventory = inventory[0]
	playerInst.weapon = inventory[1]
	add_child(playerInst)
	Globals.maps.loadMapSections(Globals.playerMapChunks)
