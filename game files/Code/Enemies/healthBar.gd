extends MeshInstance

export var maxHealth = 100

onready var healthBar = $Viewport/ProgressBar
var timer = 0


func _ready():
	healthBar.max_value = maxHealth
	get_surface_material(0).albedo_texture = $Viewport.get_texture()

func _process(delta):
	timer -= delta
	visible = (timer > 0)

func updateBar(health):
	healthBar.value = health
	timer = 3
	if healthBar.value <= 0:
		$AudioStreamPlayer3D.play()
