extends StaticBody

export var item = ""
export var state = 0
export var id = 0

func _ready():
	add_to_group("interact")
	add_to_group("save")
	state = Save.loadState(id)
	if state == 1:
		queue_free()

func interact(object):
	object.getItem(item)
	state = 1
	Save.saveStates()
	queue_free()
