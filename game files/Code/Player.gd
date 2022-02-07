extends KinematicBody

export var maxSpeed = 15

export var normalAcceleration = 10
export var airAcceleration = 1

var horizontalAcceleration = normalAcceleration

export var gravity = 50
export var jumpForce = 16
var fullContact = false

export var mouseSensitivity = 0.1

var direction = Vector3()
var horizontalVelocity = Vector3()
var movement = Vector3()
var gravityVector = Vector3()

onready var head = $head
onready var groundChecks = $feetRaycasts.get_children()

func _ready():
	add_to_group("Player")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouseSensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouseSensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-79), deg2rad(79))
	

func _process(delta):
	direction = Vector3()
	fullContact = onFloor()
	
	if not is_on_floor():
		gravityVector += Vector3.DOWN * gravity * delta
		horizontalAcceleration = airAcceleration
	elif is_on_floor() and fullContact:
		gravityVector = Vector3()
		gravityVector = -get_floor_normal() * gravity*delta
		horizontalAcceleration = normalAcceleration
	else:
		gravityVector = Vector3()
		gravityVector = -get_floor_normal()
		horizontalAcceleration = normalAcceleration
	
	if Input.is_action_just_pressed("jump") and (is_on_floor() and fullContact):
		gravityVector = get_floor_normal() * jumpForce
	
	var zdir = int(Input.is_action_pressed("moveBackwards")) - int(Input.is_action_pressed("moveForwards"))
	var xdir = int(Input.is_action_pressed("moveRight")) - int(Input.is_action_pressed("moveLeft"))
	
	direction += transform.basis.z*zdir
	direction += transform.basis.x*xdir
	
	direction = direction.normalized()
	
	horizontalVelocity = horizontalVelocity.linear_interpolate(direction*maxSpeed, horizontalAcceleration * delta)
	movement.z = horizontalVelocity.z + gravityVector.z
	movement.x = horizontalVelocity.x + gravityVector.x
	movement.y = gravityVector.y
		
	move_and_slide(movement, Vector3.UP)

func onFloor():
	for cast in groundChecks:
		if cast.is_colliding():
			return true
	return false
