extends CanvasLayer

export(NodePath) var path_to_farm
export(NodePath) var path_to_bailes
export(NodePath) var path_to_forest
export(NodePath) var path_to_start
export(NodePath) var path_to_player

onready var farm = get_node(path_to_farm)
onready var bailes = get_node(path_to_bailes)
onready var forest = get_node(path_to_forest)
onready var player = get_node(path_to_player)

func teleport_player(target_position):
	player.global_position = target_position

func _on_Button_pressed():
	match $DialogueOptions.index_get():
		0:
			teleport_player(farm.global_position)
	$AnimationPlayer.play("fade_to_black")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("fade_to_normal")
