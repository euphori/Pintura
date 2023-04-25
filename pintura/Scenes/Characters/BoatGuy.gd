extends StaticBody2D


export(NodePath) var path_to_farm
export(NodePath) var path_to_bailes
export(NodePath) var path_to_forest
export(NodePath) var path_to_start
export(NodePath) var path_to_player

onready var farm = get_node(path_to_farm)
onready var bailes = get_node(path_to_bailes)
onready var forest = get_node(path_to_forest)
onready var player = get_node(path_to_player)

var player_near

func _ready():
	$TravelOptions.visible = false
	$TravelOptions/TileMap.visible = false

func _input(event):
	if event.is_action_pressed("interact") and player_near:
		print("X")
		$TravelOptions/TileMap.visible = true
		$TravelOptions.visible = true

func teleport_player(target_position):
	player.global_position = target_position

func _on_Button_pressed():
	print($TravelOptions/DialogueOptions.index_get())
	$TravelOptions/TileMap.visible = false
	$TravelOptions/DialogueOptions.visible = false
	$TravelOptions/AnimationPlayer.play("fade_to_black")
	yield($TravelOptions/AnimationPlayer,"animation_finished")
	match $TravelOptions/DialogueOptions.index_get():
		0:
			teleport_player(farm.global_position)
	$TravelOptions/AnimationPlayer.play("fade_to_normal")
	$TravelOptions.visible = false
	$TravelOptions/TileMap.visible = true
	$TravelOptions/DialogueOptions.visible = true
	
	

func _on_InteractKey_area_entered(area):
	player_near = true
	$InteractKey.visible = true



func _on_InteractKey_area_exited(area):
	$InteractKey.visible = false
	player_near = false
