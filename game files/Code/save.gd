extends Node




func _ready():
	#create folders
	var dir = Directory.new()
	dir.open("user://")
	dir.make_dir("Characters")


func getSaves():
	var c = []
	var dir = Directory.new()
	dir.open("user://Characters")
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			c.append(file)

	dir.list_dir_end()

	return c

func savePlayer(characterName:String, spawnPos:Vector3, spawnRot:Vector3, mapChunks:Array):
	#create folders
	var dir = Directory.new()
	dir.open("user://")
	dir.make_dir("Characters")
	dir.open("user://Characters")
	dir.open("Characters")
	dir.make_dir(characterName)
	
	#save player data
	var file = File.new()
	file.open("user://Characters/" + characterName + "/playerPosition.json", File.WRITE)
	file.store_var(makePlayerJson(spawnPos, spawnRot, mapChunks))
	file.close()

func saveInventory(characterName:String, playerInventory:Array):
	#create folders
	var dir = Directory.new()
	dir.open("user://")
	dir.make_dir("Characters")
	dir.open("user://Characters")
	dir.open("Characters")
	dir.make_dir(characterName)
	
	#save player data
	var file = File.new()
	file.open("user://Characters/" + characterName + "/inventory.json", File.WRITE)
	file.store_var(playerInventory)
	file.close()


func makePlayerJson(spawnPos, spawnRot, mapChunks):
	var data = {
		"Player": {
			"spawnPos": spawnPos,
			"spawnRot": spawnRot,
			"mapChunks": mapChunks,
		}
	}
	return data

func loadPlayerPos(characterName):
	#get player data
	var file = File.new()
	if file.file_exists("user://Characters/" + characterName + "/playerPosition.json"):
		file.open("user://Characters/" + characterName + "/playerPosition.json", File.READ)
		var json = file.get_var(true)
		file.close()
		
	
func loadPlayerInventory(characterName):
	#get player data
	var inventory = []
	
	var file = File.new()
	if file.file_exists("user://Characters/" + characterName + "/inventory.json"):
		file.open("user://Characters/" + characterName + "/inventory.json", File.READ)
		inventory = file.get_var(true)
	
	return inventory

func loadPlayer(characterName):
	#get player data
	var file = File.new()
	if file.file_exists("user://Characters/" + characterName + "/playerPosition.json"):
		file.open("user://Characters/" + characterName + "/playerPosition.json", File.READ)
		var json = file.get_var(true)
		file.close()
		
		#set variables to player data
		Globals.playerSpawnPos = json.Player.spawnPos
		Globals.playerSpawnRot = json.Player.spawnRot
		Globals.playerMapChunks = json.Player.mapChunks
		
		Globals.playerInventory = loadPlayerInventory(characterName)
		
		Globals.player = json.Player

