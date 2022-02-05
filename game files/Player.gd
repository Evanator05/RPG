extends KinematicBody

var movement = Vector3()

var mouse_sense = 0.01

var jumpForce = 8
var acceleration = 128

var gravity = 9.81

onready var feetRaycasts = $feetRaycasts.get_children()

func _ready():
	Input.set_mouse_mode(2) # Capture and hide mouse

func _input(event):
	#player looking
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x*mouse_sense)
		$head.rotate_x(-event.relative.y*mouse_sense)
		$head.rotation_degrees.x = clamp($head.rotation_degrees.x, -90, 90)
		
func _physics_process(delta):
	
	movement.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and onFloor():
		movement.y += jumpForce
	if Input.is_action_pressed("moveForwards"):
		pass
	
	if onFloor() and is_on_floor():
		movement.y = 0
	
	move_and_slide(movement, Vector3.UP)
		
func onFloor():
	for cast in feetRaycasts:
		if cast.is_colliding():
			return true
