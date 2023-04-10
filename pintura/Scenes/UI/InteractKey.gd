extends Sprite



export (String, "Open", "Talk") var text

func _ready():
	$Label.text = text
	$AnimationPlayer.play("bob")
	


func _on_Area2D_area_entered(area):
	visible = true
	get_parent().player_near = true


func _on_Area2D_area_exited(area):
	get_parent().player_near = false

