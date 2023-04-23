extends "res://Scripts/EventCharacters.gd"




func _physics_process(delta):
	if !stationary:
		if go_to_destination(0):
			GameState.creature_can_move = false
			if !timer_set:
				$Timer.start(1)
				timer_set = true


func _on_Timer_timeout():
	queue_free()

