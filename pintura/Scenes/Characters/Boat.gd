extends KinematicBody2D

var player_near = false

func _input(event):
	if event.is_action_pressed("interact") and player_near:
		
