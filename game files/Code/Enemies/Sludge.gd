extends KinematicBody
var movement = Vector3()

var health = 30
var maxHealth = 30
var state = "alive"

var speed = 5
var gravity = 30
onready var sounds = $AudioStreamPlayer3D
onready var healthBar = $healthBar

var trackingPos = null

func _ready():
	add_to_group("health")

func _process(delta):
	
	match state:
		"alive":
			alive(delta)
		"attack":
			attack(delta)
		"dead":
			movement = Vector3()
			if not $AnimationPlayer.is_playing():
				queue_free()
				
	movement.y += -gravity*delta
	movement = move_and_slide(movement)

func alive(delta):
	for body in $vision.get_overlapping_bodies():
		if body.is_in_group("Player"):
			findLocation(body)
	
	for body in $hitbox.get_overlapping_bodies():
		if body.is_in_group("Player"):
			state = "attack"
			$AnimationPlayer.play("attack")
	
	if not trackingPos == null:
		var angle = getAngleTo(trackingPos)
		movement.x = cos(angle)*speed
		movement.z = sin(angle)*speed
		rotation.y = lerp_angle(rotation.y, -angle-deg2rad(90), 1 - pow(0.02, delta))
		if round(global_transform.origin.x) == round(trackingPos.x) and round(global_transform.origin.z) == round(trackingPos.z):
			trackingPos = null
			movement.x = 0
			movement.z = 0

func attack(delta):

	if not $AnimationPlayer.is_playing():
		state = "alive"
	for body in $vision.get_overlapping_bodies():
		if body.is_in_group("Player"):
			findLocation(body)
	var angle = getAngleTo(trackingPos)
	rotation.y = lerp_angle(rotation.y, -angle-deg2rad(90), 1 - pow(0.08, delta))

func dealDamage(dmg):
	for body in $hitbox.get_overlapping_bodies():
		if body.is_in_group("Player"):
			body.takeDamage(dmg)

func takeDamage(dealer, dmg):
	if health > 0:
		findLocation(dealer)
		health -= dmg
		healthBar.updateBar(health)
		if health <= 0:
			die()
		else:
			sounds.stream = load("res://Audio/Enemies/Sludge/sludgeDamage.wav")
			sounds.play()

func die():
	state = "dead"
	$AnimationPlayer.stop()
	$AnimationPlayer.play("die")
	$CollisionShape.disabled = true


func getAngleTo(position):
	var rangle = 0
	if translation.z - position.z != 0 and translation.x - position.x != 0:
		rangle = atan((translation.z - position.z)/(translation.x - position.x))
	
	if translation.x > position.x:
		rangle -= deg2rad(180)
	
	return rangle

func findLocation(object):
	trackingPos = object.global_transform.origin
