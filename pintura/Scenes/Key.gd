extends StaticBody2D

var player_near = false
export(String, "MuseumKey") var key_id

func _input(event):
	if event.is_action_pressed("interact") and player_near:
		PlayerInventory.add_item(key_id,1)
		queue_free()
