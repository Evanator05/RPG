extends KinematicBody

var movement = Vector3()

onready var liftGears = preload("res://Audio/liftGears.wav")
onready var liftStop = preload("res://Audio/liftStop.wav")

export var topPos = 0
export var botPos = 0
export var startTop = false

export var maxSpeed = 10
var speed = 0

var isMoving = false
var direction = 1

onready var buttonModel = $buttonModel

func _ready():
	global_transform.origin.y = (topPos*int(startTop)) + (botPos*int(not startTop))
	direction = 1 - (2 * int(not startTop))

func _process(delta):
	var currentPos = abs((global_transform.origin.y/(topPos-botPos))*100)
	speed = (pow(currentPos,2)/-50)+2*currentPos
	speed = clamp(speed, .5, maxSpeed)
	
	if global_transform.origin.y > topPos or global_transform.origin.y < botPos:
		stopMoving()
	
	movement.y = int(isMoving) * direction * speed * delta

	buttonModel.translation.y = lerp(buttonModel.translation.y, 1-(int(isMoving)*0.45), 1 - pow(0.02, delta))
	#move objects on elevator
	if movement.y < 0:
		for body in $standingArea.get_overlapping_bodies():
			body.global_transform.origin += movement
	
	global_transform.origin += movement

func startMoving():
	isMoving = true
	direction = direction*-1
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
