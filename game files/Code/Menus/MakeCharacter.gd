extends Control

onready var playerName = $Name

var classes = [["Barbarian",["Axe"]], ["Assassan",["Knife"]], ["Everything",["Axe", "Knife", "Abyss", "Church Key"]]]

func _ready():
	for className in classes:
		$OptionButton.add_item(className[0])
	updateItems($OptionButton.selected)

func createCharacter(pName:String):
	var items = classes[$OptionButton.selected][1]
	Save.savePlayer(pName, Vector3(305,2,274), Vector3(0,90,0), [1])
	Save.saveInventory(pName, items, items[0])
	Globals.playerName = pName
	var _scene = get_tree().change_scene("res://Level.tscn")

func _on_CreateCharacter_pressed():
	var text = playerName.text.replace(" ", "")
	if text != "":
		text = text.replace("/", "")
		text = text.replace(".", "")
		text = text.replace(":", "")
		text = text.replace(";", "")
		text = text.replace("|", "")
		createCharacter(text)
	else:
		$error.visible = true


func _on_OptionButton_item_selected(index):
	updateItems(index)
	
func updateItems(index):
	var string = "Items:\n"
	for i in classes[index][1]:
		string += i + "\n"

	$items.text = string


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menus/CharacterSelect.tscn")
