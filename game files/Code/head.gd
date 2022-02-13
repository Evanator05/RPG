extends Spatial

var timer = 0
var moving = false
func _process(delta):
	if moving:
		timer += delta
	else:
		timer = 0
		
	var handPos = $hand.translation
	$hand.translation.x = lerp(handPos.x, sin(timer*4)*0.05+0.293, 1 - pow(0.2,delta))
	$hand.translation.y = lerp(handPos.y, sin(timer*4)*0.05-0.178, 1 - pow(0.2,delta))
	$hand.translation.z = lerp(handPos.z, sin(timer*8)*0.025-0.302, 1 - pow(0.2,delta))
	
	$hand.rotation_degrees.x = lerp($hand.rotation_degrees.x, 0, 1 - pow(0.002,delta))
	$hand.rotation_degrees.y = lerp($hand.rotation_degrees.y, -3.913, 1 - pow(0.002,delta))
	$hand.rotation_degrees.z = lerp($hand.rotation_degrees.z, 0, 1 - pow(0.002,delta))
