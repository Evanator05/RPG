extends Spatial

var time = 0

func generateIcon(model):
	for child in $Viewport/item.get_children():
		child.queue_free()
		
	model = load(model)
	var modelInst = model.instance()
	$Viewport/item.add_child(modelInst)
	
	var icon = $Viewport.get_texture()
	
	return icon
	
func _process(delta):
	time += delta
	$Viewport/item.rotation_degrees.y = sin(time)*15-90
