extends Area

func _ready():
	$MeshInstance.visible = false
	
func _on_DeathTrigger_body_entered(body):
	if body.is_in_group("health"):
		body.die()
