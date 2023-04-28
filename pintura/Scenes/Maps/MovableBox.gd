extends KinematicBody2D

var player_near
var velocity = Vector2.ZERO

export (int) var push_strength = 5
export (NodePath) var path_to_player
onready var player = get_node(path_to_player)




func _input(event):
	if event.is_action_pressed("interact"):
		var target
		var direction = player.global_position.direction_to(global_position)
		if $Down.is_colliding() or $Up.is_colliding():
			target = direction.y * push_strength
			position.y += direction.y * push_strength
		elif $Right.is_colliding() or $Left.is_colliding():
			target = direction.x * push_strength
			position.x += direction.x * push_strength
		
		$Tween.interpolate_property(self,"position", target, 3, Tween.TRANS_QUINT,Tween.EASE_OUT)
		$Tween.start()
		print(direction)
