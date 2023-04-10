extends Sprite


func _ready():
	$AnimationPlayer.play("bob")
	


func _on_Area2D_area_entered(area):
	visible = true
	get_parent().player_near = true


func _on_Area2D_area_exited(area):
	get_parent().player_near = false

