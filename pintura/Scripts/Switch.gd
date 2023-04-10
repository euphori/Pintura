
extends StaticBody2D




var player_near = false
export (bool) var is_switch
signal trigger_switch

func _input(event):
	if event.is_action_pressed("interact") and player_near:
		if is_switch:
			emit_signal("trigger_switch")
		toggle_lights()

func toggle_lights():
	if $Light2D.visible == false:
		$Light2D.visible = true
		$Sprite.texture = load("res://Assets/Interior/lamp_on.tres")
	else:
		$Light2D.visible = false
		$Sprite.texture = load("res://Assets/Interior/lamp_off.tres")


