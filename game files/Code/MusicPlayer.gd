extends Area

export var songPath = ""
var volume = 0

func _ready():
	$AudioStreamPlayer.stream = load(songPath)
	$AudioStreamPlayer.volume_db = -80
	$AudioStreamPlayer.play()
	$MeshInstance.visible = false

func _process(delta):
	volume = -80
	for body in get_overlapping_bodies():
		if body.is_in_group("Player"):
			volume = 0
	
	$AudioStreamPlayer.volume_db = lerp($AudioStreamPlayer.volume_db, volume, 1 - pow(0.8, delta))
