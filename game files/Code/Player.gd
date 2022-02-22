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
onready var ui = $UI
onready var attackHitbox = $head/attackHitbox

var maxHealth = 100
var health = 100

var groundHeight = 0

var inventory = []
var healths = 3

var damage = 1
var attackAnimation = ""
var weapon = "Axe"

func _ready():
	add_to_group("Player")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	inventory = Globals.playerInventory
	ui.updateUI(health)
	updateWeapon(inventory[0])
	
func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
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
		
		#fall damage
		var heightDiff = abs(groundHeight - global_transform.origin.y)
		if heightDiff > 20:
			takeDamage(pow((heightDiff-15),2))
		groundHeight = global_transform.origin.y
		
	else:
		gravityVector = -get_floor_normal()

	
	if Input.is_action_just_pressed("jump") and (is_on_floor() and fullContact):
		gravityVector = get_floor_normal() * jumpForce
	
	var zdir = int(Input.is_action_pressed("moveBackwards")) - int(Input.is_action_pressed("moveForwards"))
	var xdir = int(Input.is_action_pressed("moveRight")) - int(Input.is_action_pressed("moveLeft"))
	head.moving = xdir or zdir
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
	ui.setCrosshair(false)
	var collision = interactCast.get_collider()
	if collision != null:
		if collision.is_in_group("interact"):
			ui.setCrosshair(true)
			if Input.is_action_just_pressed("interact"):
				collision.interact(self)
	
	#healing
	if Input.is_action_just_pressed("heal") and healths > 0:
		heal(100)
		healths -= 1
	
	#attacking
	if Input.is_action_just_pressed("attack"):
		startAttacking()

func updateWeapon(weaponName:String):
	weapon = WeaponManager.items["items"][weaponName]
	damage = weapon["damage"]
	attackAnimation = weapon["animations"]
	for child in $head/hand/Weapon.get_children():
		child.queue_free()
	var weaponInst = load(weapon["model"]).instance()
	weaponInst.translation = weapon["position"]
	$head/hand/Weapon.add_child(weaponInst)

func startAttacking():
	$head/attackAnimations.play(attackAnimation)
	maxSpeed = 2

func stopAttacking():
	if not Input.is_action_pressed("attack"):
		$head/attackAnimations.stop()
		maxSpeed = 15

func dealDamage(multiplier:int):
	for body in attackHitbox.get_overlapping_bodies():
		if body.is_in_group("health"):
			body.takeDamage(self, damage*multiplier)

func takeDamage(damageAmount):
	health -= damageAmount

	ui.updateHealthBar(health)
	if health <= 0:
		die()

func heal(healAmount):
	health += healAmount
	health = clamp(health, 0, maxHealth)
	ui.updateHealthBar(health)

func die():
	Globals.loadPlayer(Globals.playerName)
	var scene = get_tree().reload_current_scene()
