extends Node

var items = {
	"items": {
		"weapon template": {
			"type": "weapon",
			"name": "template weapon",
			"description": "just for testing",
			"model": "model path",
			"position": Vector3(0, 0, 0),
			"animations": "name of the weapons attacking animation",
			"damage": 5,
			"icon": "path to the items icon (if you type 'model' then it will use the model as the icon)"
			},
		"Axe": {
			"type": "weapon",
			"name": "Axe",
			"description": "Just a regular axe",
			"model": "res://Models/Weapons/Scenes/Axe.tscn",
			"position": Vector3(0, 0.04, 0),
			"animations": "axeSwing",
			"damage": 5,
			"icon": "model"
			},
		"Knife": {
			"type": "weapon",
			"name": "Dagger",
			"description": "A common dagger used by assasins",
			"model": "res://Models/Weapons/Scenes/Knife.tscn",
			"position": Vector3(0, 0, 0),
			"animations": "KnifeSwing",
			"damage": 2,
			"icon": "model"
			},
		"Abyss": {
			"type": "weapon",
			"name": "Abyssal Blade",
			"description": "A blade formed within the abyss",
			"model": "res://Models/Weapons/Scenes/Abyss.tscn",
			"position": Vector3(0, 0, 0),
			"animations": "KnifeSwing",
			"damage": 8,
			"icon": "model"
		},
		"Church Key": {
			"type": "key",
			"name": "Church Key",
			"description": "crewmer",
			"icon": "res://Materials/UI/keyIcon.png"
		}

	}
}
