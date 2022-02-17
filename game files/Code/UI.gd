extends Control

var fadeAmount = 0

onready var healthBar = $HealthBar/ProgressBar
onready var player = get_parent()

onready var inventory = $Inventory

func _process(delta):
	$screenFade.color.a = lerp($screenFade.color.a, fadeAmount, 1 - pow(0.5,delta))

func updateUI(health:int, inventory:Array):
	updateHealthBar(health)
	
func updateHealthBar(amount:int):
	healthBar.value = amount
