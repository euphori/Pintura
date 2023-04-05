extends Node2D



func _input(event):
	if event.is_action_pressed("journal"):
		if visible == false:
			visible = true
		else:
			visible = false
