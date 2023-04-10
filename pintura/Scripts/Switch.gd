
extends StaticBody2D




var player_near = false
export (bool) var is_switch
signal trigger_switch

func _input(event):
	if event.is_action_pressed("interact") and player_near:
		if is_switch:
			emit_signal("trigger_switch")
		$Light2D.visible = true
		on_lights()

func on_lights():
	$Sprite.texture = load("res://Assets/Interior/lamp_on.tres")


