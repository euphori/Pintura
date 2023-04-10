extends Area2D
var player_nearby = false
onready var interact_label = get_parent().get_node("InteractKey")

func _input(event):
	if event.is_action_pressed("interact") and player_nearby:
		use_dialogue()
		interact_label.visible = false
		

func use_dialogue():
	var dialogue = get_parent().get_node("Dialogue")
	
	if dialogue:
		dialogue.start()

  

 
func _on_PlayerDetection_area_entered(area):

	player_nearby = true




func _on_PlayerDetection_area_exited(area):
	player_nearby = false
