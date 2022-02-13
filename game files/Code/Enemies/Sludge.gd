extends KinematicBody


var health = 30
var maxHealth = 30
var state = "alive"

onready var sounds = $AudioStreamPlayer3D
onready var healthBar = $healthBar

func _ready():
	add_to_group("health")


func _process(delta):
	match state:
		"alive":
			pass
		"dead":
			if not sounds.playing:
				queue_free()
	
func takeDamage(dmg):
	if health > 0:
		health -= dmg
		healthBar.updateBar(health, maxHealth)
		if health <= 0:
			die()

func die():
	state = "dead"
	sounds.stream = load("res://Audio/Enemies/Sludge/sludgeKill.wav")
	sounds.play()
