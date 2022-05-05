extends Control

export var text = ""

func _ready():
	$Label.text = text

func _input(event):
	if Input.is_action_just_pressed("interact"):
		queue_free()
