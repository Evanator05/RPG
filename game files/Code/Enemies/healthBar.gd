extends MeshInstance

onready var healthBar = $Viewport/ProgressBar
var timer = 0

func _process(delta):
	timer -= delta
	visible = (timer > 0)

func updateBar(health, maxHealth):
	healthBar.max_value = maxHealth
	healthBar.value = health
	timer = 3
	if healthBar.value <= 0:
		$AudioStreamPlayer3D.play()
