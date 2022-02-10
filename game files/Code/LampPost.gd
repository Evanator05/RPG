extends StaticBody


onready var spawnPos = get_node("SpawnPos")
export var spawnRot = 0
export var mapChunks = []

var time = 0

func _ready():
	add_to_group("interact")

func _process(delta):
	time += delta
	$orb.translation.y = sin(time*2)*.05 + 4
	$LampCage.translation.y = sin(time*-2)*.025
	$LampCage.rotation_degrees.y = sin(-time)*2.5
	$LampCage.rotation_degrees.x = sin(-time*.5)*.5
	$LampCage.rotation_degrees.z = cos(-time*.5)*.5

func interact(object):
	Globals.playerSpawnPos = spawnPos.global_transform.origin
	Globals.playerMapChunks = mapChunks
	Globals.playerSpawnRot.y = spawnRot
	$activate.play()

