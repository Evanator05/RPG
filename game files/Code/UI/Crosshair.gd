extends Control

func setCrosshair(interacting:bool):
	$ColorRect.visible = not interacting
	$Label.visible = interacting
