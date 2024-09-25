extends MeshInstance

var time = 0.0
func _process(delta):
	time += delta*0.2
	scale.x = sin(time)*50+500
	scale.y = cos(time)*50+500
	scale.z = sin(time)*50+500
