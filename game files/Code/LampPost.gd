extends StaticBody

onready var spawnPos = get_node("SpawnPos")
export var spawnRot = 0
export var mapChunks = []

var time = 0

func _ready():
	add_to_group("interact")

func _process(delta):
	time += delta
	$orb.translation.y = sin(time/2)*.025 + 4
	$LampCage.translation.y = sin(time/2)*.0025
	$LampCage.rotation_degrees.y = sin(time/2)*.5
	$LampCage.rotation_degrees.x = sin(time/4)*.25
	$LampCage.rotation_degrees.z = cos(time/4)*.25

func interact(object):
	Globals.savePlayer(Globals.playerName, spawnPos.global_transform.origin, Vector3(0,spawnRot,0), mapChunks, object.inventory)
	
	$activate.play()
