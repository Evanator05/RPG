extends Control

onready var playerName = $Name

func createCharacter(pName:String):
	Globals.savePlayer(pName, Vector3(311,2,274), Vector3(0,90,0), [1])
	Globals.playerName = pName
	var _scene = get_tree().change_scene("res://Level.tscn")


func _on_CreateCharacter_pressed():
	var text = playerName.text.replace(" ", "")
	if text != "":
		text = text.replace("/", "")
		text = text.replace(".", "")
		text = text.replace(":", "")
		text = text.replace(";", "")
		createCharacter(text)