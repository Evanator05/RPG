extends Control

var fadeAmount = 0

onready var healthBar = $HealthBar/ProgressBar
onready var itemList = $Inventory/ItemList

func _process(delta):
	$screenFade.color.a = lerp($screenFade.color.a, fadeAmount, 1 - pow(0.5,delta))

func updateUI(health:int, inventory:Array):
	updateHealthBar(health)
	updateInventory(inventory)
	
func updateHealthBar(amount:int):
	healthBar.value = amount

func updateInventory(inventory:Array):
	for i in itemList.items:
		itemList.remove_item(0)
	for item in inventory:
		itemList.add_item(item)
