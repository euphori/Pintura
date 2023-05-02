extends Area2D



export (String, "Open", "Talk", "Toggle", "Grab", "Exit", "Interact", "Push") var text


func _ready():

	$Label.text = text
	$AnimationPlayer.play("bob")


func _on_InteractKey_area_entered(area):
	if get_parent().get_name() == "Door":
		if get_parent().switch_on == false and get_parent().need_switch == true:
			visible = false
		else:
			visible = true
	else:
		visible = true
	if get_parent().get("player_near") != null:
		print("IS PLAYER NEAR:")
		print(get_parent().get("player_near"))
		get_parent().player_near = true

func _input(event):
	if event.is_action_pressed("interact") and get_parent().get("player_near") and get_parent().get_name() != "Door":
		use_dialogue()
		visible = false
		

func use_dialogue():
	var dialogue = get_parent().get_node("Dialogue")
	
	if dialogue:
		dialogue.start()


func _on_InteractKey_area_exited(area):
	visible = false
	if get_parent().get("player_near") != null:
		get_parent().player_near = false


