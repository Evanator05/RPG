extends Control

var value = 0

func _process(delta):
	$ProgressBar.value = lerp($ProgressBar.value, value, 1 - pow(0.0002, delta))

func setValue(amount:int):
	value = amount
