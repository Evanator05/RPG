extends Control


var inventoryType = "weapon"
onready var itemList = $ItemList
onready var player = get_parent().player

func _input(_event):
	if Input.is_action_just_pressed("inventory"):
		toggleInventory()

func updateInventory(inventory:Array, type:String):
	if itemList.items.size() > 0:
		for i in itemList.items:
			itemList.remove_item(0)
	for item in inventory:
		if WeaponManager.items["items"][item]["type"] == type:
			itemList.add_item(item)
			var icon = $GenerateIcon.generateIcon(WeaponManager.items["items"][item]["model"])
			itemList.set_item_icon(itemList.get_item_count()-1,icon)

func toggleInventory():
	visible = not visible
	
	if visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		updateInventory(get_parent().player.inventory, inventoryType)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func _on_ItemList_item_selected(index):
	match inventoryType:
		"weapon":
			get_parent().player.updateWeapon(itemList.get_item_text(index))
