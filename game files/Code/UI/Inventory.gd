extends Control


var inventoryType = "weapon"
var items = []
onready var itemList = $ItemList
onready var player = get_parent().player
onready var iconScene = preload("res://Objects/UI/GenerateIcon.tscn")
onready var icons = $Icons

func _input(_event):
	if Input.is_action_just_pressed("inventory"):
		toggleInventory()

func updateInventory(inventory:Array, type:String):
	items = []
	for i in itemList.items:
		itemList.remove_item(0)
	for child in icons.get_children():
		child.queue_free()
		
	for item in inventory:
		if WeaponManager.items["items"][item]["type"] == type:
			itemList.add_item(WeaponManager.items["items"][item]["name"])
			items.append(item)
			var icon
			
			if WeaponManager.items["items"][item]["icon"] == "model":
				var iconInst = iconScene.instance()
				icons.add_child(iconInst)
				icon = iconInst.generateIcon(WeaponManager.items["items"][item]["model"])
			else:
				icon = load(WeaponManager.items["items"][item]["icon"])
			
			itemList.set_item_icon(itemList.get_item_count()-1, icon)

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
			get_parent().player.updateWeapon(items[index])
			Save.saveInventory(Globals.playerName, get_parent().player.inventory, items[index])
