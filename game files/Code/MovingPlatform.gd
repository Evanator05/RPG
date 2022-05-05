extends StaticBody

var movement = Vector3()

export(Resource) var liftGears
export(Resource) var liftStop

export var topPos = 0
export var botPos = 0
export var startTop = false

export var state = 0
export var id = 0

export var maxSpeed = 10
var speed = 0

var isMoving = false
var direction = 1

onready var buttonModel = $buttonModel


func _ready():
	add_to_group("save")
	state = Save.loadState(id)
	if not(state == 0):
		startTop = clamp(state, 0, 1)
	global_transform.origin.y = (topPos*int(startTop)) + (botPos*int(not startTop))
	direction = 1 - (2 * int(not startTop))
	

func _process(delta):
	var currentPos = .5

	speed = -4*pow(currentPos-.5,2)+1
	speed = clamp(speed, .2, 1)

	movement.y = int(isMoving) * direction * speed * maxSpeed * delta

	buttonModel.translation.y = lerp(buttonModel.translation.y, 1-(int(isMoving)*0.45), 1 - pow(0.02, delta))
	#move objects on elevator
	for body in $standingArea.get_overlapping_bodies():
		body.global_transform.origin += movement
	
	global_transform.origin += movement
	
	if global_transform.origin.y > topPos or global_transform.origin.y < botPos:
		stopMoving()

func startMoving():
	isMoving = true
	direction = direction*-1
	state = direction
	Save.saveStates()
	$gearSounds.stream = liftGears
	$gearSounds.play()

func stopMoving():
	isMoving = false
	global_transform.origin.y = clamp(global_transform.origin.y, botPos, topPos)
	$gearSounds.stream = liftStop
	$gearSounds.play()

func _on_button_body_entered(body):
	if body.is_in_group("Player"):
		if not isMoving:
			startMoving()
