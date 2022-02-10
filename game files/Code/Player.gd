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
onready var interactCast = $head/interactCast


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
	fullContact = $floorCast.is_colliding()
	
	if not is_on_floor():
		gravityVector += Vector3.DOWN * gravity * delta
		horizontalAcceleration = airAcceleration
	elif is_on_floor() and fullContact:
		gravityVector = -get_floor_normal() * gravity
		horizontalAcceleration = normalAcceleration
	else:
		gravityVector = -get_floor_normal()

	
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
	
	movement += get_floor_velocity()
	
	move_and_slide(movement, Vector3.UP)
	
	#interacting
	if Input.is_action_just_pressed("interact"):
		var collision = interactCast.get_collider()
		if collision != null:
			if collision.is_in_group("interact"):
				collision.interact(self)

func die():
	print("Hi my name is Carmen Winstead. I'm 17 years old. I am very similar to you... Did I mention to you that I'm dead. A few years ago a group of girls pushed me down a sewer hole to try and embarrass me. When I didn't come back up the police came. The girls said that I had fell and everyone believed them. The police found my body in the sewer. I had a broken neck and my face was torn off. Send this message to 15 people after you read the whole message if you value your life! A boy called David received this message. He just laughed and deleted it. When he was in the shower he heard laughing... MY LAUGHTER! He got really scared, rushed to his phone to repost this message... But he was too late. The next morning his mum entered his bedroom and all she found was a message written in his blood saying, You will never have him back! No one has found his body yet... because he is with me!... Send this to 15 people in the next 5 minutes if you don't want your fate to be the same as David's. Your time starts... NOW! The story is true you can research it on google")
	get_tree().reload_current_scene()
