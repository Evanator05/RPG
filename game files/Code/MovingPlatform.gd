extends KinematicBody

var movement = Vector3()

export var topPos = 0
export var botPos = 0
export var startTop = false
export var speed = 5
var isMoving = false
var direction = 1

func _ready():
	global_transform.origin.y = (topPos*int(startTop)) + (botPos*int(not startTop))

func _process(delta):
	movement.y = int(isMoving) * direction * speed*delta
	if global_transform.origin.y > topPos or global_transform.origin.y < botPos:
		isMoving = false
		global_transform.origin.y = clamp(global_transform.origin.y, botPos, topPos)
	global_transform.origin += movement
	

func _on_button_body_entered(body):
	if body.is_in_group("Player"):
		if not isMoving:
			isMoving = true
			direction = direction*-1
