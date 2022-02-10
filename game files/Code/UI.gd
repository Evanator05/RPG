extends Control

var fadeAmount = 0

onready var healthBar = $HealthBar/ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$screenFade.color.a = lerp($screenFade.color.a, fadeAmount, 1 - pow(0.5,delta))

func updateHealthBar(amount):
	healthBar.value = amount
