extends StaticBody2D


export(NodePath) var path_to_farm
export(NodePath) var path_to_bailes
export(NodePath) var path_to_forest
export(NodePath) var path_to_start
export(NodePath) var path_to_player
export var distance_to_player = 5

onready var player = get_node(path_to_player)


onready var locations = {
	
	"Farm" :get_node(path_to_farm),
	"Bailles de Luces":get_node(path_to_bailes),
	"Forest":get_node(path_to_forest),
	"Back to Main Island": get_node(path_to_start)
}

var player_near
var current_location

func _ready():
	$TravelOptions.visible = false
	$TravelOptions/TileMap.visible = false

func _input(event):
	if event.is_action_pressed("interact") and player_near:
		for i in get_tree().get_nodes_in_group("ui_asset"):
			i.visible = true
		$TravelOptions.update_labels()
		$TravelOptions/TileMap.visible = true
		$TravelOptions.visible = true



func transistion(target_position):
	$TravelOptions/AnimationPlayer.play("fade_to_black")
	yield($TravelOptions/AnimationPlayer,"animation_finished")
	player.global_position = target_position
	self.global_position = player.global_position + Vector2(distance_to_player,distance_to_player)
	for i in get_tree().get_nodes_in_group("ui_asset"):
		i.visible = false
	$TravelOptions/AnimationPlayer.play("fade_to_normal")
	yield($TravelOptions/AnimationPlayer,"animation_finished")

	

func _on_Button_pressed():
	print($TravelOptions/DialogueOptions.index_get())
	$TravelOptions/TileMap.visible = false
	$TravelOptions/DialogueOptions.visible = false
	
	match $TravelOptions/DialogueOptions.index_get():
		0:
			if current_location != "Farm":
				current_location = "Farm"
				transistion(locations["Farm"].global_position)
			else:
				current_location = $TravelOptions.label1.get_text()
				transistion(locations[$TravelOptions.label1.get_text()].global_position)
		1:
			current_location = $TravelOptions.label2.get_text()
			transistion(locations[$TravelOptions.label2.get_text()].global_position)

		2:
			current_location = $TravelOptions.label3.get_text()
			transistion(locations[$TravelOptions.label3.get_text()].global_position)

		3:
			$TravelOptions.visible = false

	$TravelOptions/TileMap.visible = true
	$TravelOptions/DialogueOptions.visible = true
	
	

func _on_InteractKey_area_entered(area):
	player_near = true
	$InteractKey.visible = true



func _on_InteractKey_area_exited(area):
	$InteractKey.visible = false
	player_near = false
