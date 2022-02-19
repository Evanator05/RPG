extends Control

var fadeAmount = 0


onready var player = get_parent()

onready var healthBar = $HealthBar
onready var inventory = $Inventory
onready var crosshair = $Crosshair

func _process(delta):
	$screenFade.color.a = lerp($screenFade.color.a, fadeAmount, 1 - pow(0.5,delta))

func updateUI(health:int):
	updateHealthBar(health)
	
func updateHealthBar(amount:int):
	healthBar.setValue(amount)
	
func setCrosshair(interacting:bool):
	crosshair.setCrosshair(interacting)
