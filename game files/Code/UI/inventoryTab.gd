extends TextureButton

export var tab = "weapon"

func _on_inventoryTab_pressed():
	var inventory = get_parent()
	inventory.inventoryType = tab
	inventory.updateInventory(inventory.get_parent().player.inventory,inventory.inventoryType)
