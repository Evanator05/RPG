extends Spatial

func generateIcon(model):
	for child in $item.get_children():
		child.queue_free()
		
	model = load(model)
	var modelInst = model.instance()
	$item.add_child(modelInst)
	
	var icon = $Viewport.get_texture()
	
	return icon
	
