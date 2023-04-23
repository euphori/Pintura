extends Area2D



export (String, "Open", "Talk", "Toggle", "Grab") var text


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
		get_parent().player_near = true



func _on_InteractKey_area_exited(area):
	visible = false
	if get_parent().get("player_near") != null:
		get_parent().player_near = false

