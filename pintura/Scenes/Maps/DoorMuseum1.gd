extends Sprite


var player_near = false



func _input(event):
	if event.is_action_pressed("interact") and player_near:
		get_tree().change_scene("res://Scenes/Maps/HiddenRoom.tscn")
