extends Sprite



export (String, "Open", "Talk", "Toggle", "Grab") var text

func _ready():
	print(get_parent().get_name())
	$Label.text = text
	$AnimationPlayer.play("bob")
	


func _on_Area2D_area_entered(area):
	if get_parent().get_name() == "Door":
		if get_parent().switch_on == false and get_parent().need_switch == true:
			visible = false
		else:
			visible = true
	else:
		visible = true
	get_parent().player_near = true


func _on_Area2D_area_exited(area):
	visible = false
	get_parent().player_near = false

