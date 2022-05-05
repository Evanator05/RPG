extends CSGCombiner

var state = 0
export var id = 0
var isMoving = false
func _ready():
	add_to_group("save")
	state = Save.loadState(id)
	if state == 1:
		translation.y = -214
		isMoving = true
	

func startMoving():
	$AnimationPlayer.play("opening")
	state = 1
	isMoving = true
	Save.saveStates()
