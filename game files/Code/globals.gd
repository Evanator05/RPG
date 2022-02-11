extends Node

var maps
var mapIds = ["TheHub", "TheForest", "TheSewers"]
var player
var playerSpawnPos
var playerSpawnRot
var playerMapChunks
var playerName

func _ready():
	savePlayer("Evan", Vector3(),Vector3(),[0,1])

func getSaves():
	var characters = []
	var dir = Directory.new()
	dir.open("user://Characters")
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			characters.append(file)

	dir.list_dir_end()

	return characters

func savePlayer(playerName:String, spawnPos:Vector3, spawnRot:Vector3, mapChunks:Array):
	#create folders
	var dir = Directory.new()
	dir.open("user://")
	dir.make_dir("Characters")
	dir.open("user://Characters")
	dir.open("Characters")
	dir.make_dir(playerName)
	
	#save player data
	var file = File.new()
	file.open("user://Characters/" + playerName + "/playerPosition.json", File.WRITE)
	file.store_var(makePlayerJson(spawnPos, spawnRot, mapChunks))
	file.close()
	
func makePlayerJson(spawnPos, spawnRot, mapChunks):
	var data = {
		"Player": {
			"spawnPos": spawnPos,
			"spawnRot": spawnRot,
			"mapChunks": mapChunks
		}
	}
	return data

func loadPlayer(playerName):
	#get player data
	var file = File.new()
	if file.file_exists("user://Characters/" + playerName + "/playerPosition.json"):
		file.open("user://Characters/" + playerName + "/playerPosition.json", File.READ)
		var json = file.get_var(true)
		file.close()
		
		#set variables to player data
		playerSpawnPos = json.Player.spawnPos
		playerSpawnRot = json.Player.spawnRot
		playerMapChunks = json.Player.mapChunks
		
		player = json

