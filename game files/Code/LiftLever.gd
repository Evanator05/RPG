extends StaticBody

export(NodePath) var lift

func _ready():
	add_to_group("interact")
	lift = get_node(lift)

func interact(_object):
	if not lift.isMoving:
		lift.startMoving()
		$AnimationPlayer.play("flip")
