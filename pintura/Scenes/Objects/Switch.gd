extends StaticBody2D


var player_near = false
signal trigger_switch

func _input(event):
	if event.is_action_pressed("interact") and player_near:
		emit_signal("trigger_switch")


func _on_PlayerDetection_area_entered(area):
	player_near = true


func _on_PlayerDetection_area_exited(area):
	player_near = false
