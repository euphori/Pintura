extends Node2D




onready var collision =  $CutsceneTrigger/CollisionShape2D

export var path_to_player := NodePath()
export var return_camera_after_dialogue = false
onready var player = get_node(path_to_player)

const PAN_SPEED = 3

var on_scene = false
var end_scene = false
var creature_involved = false
var camera_involved = false
var dialogue_involved = false
var creature
var camera
var dialogue 
var timer_set = false
var original_camera_position
var player_camera

func _ready():
	if is_instance_valid($Navigation2D/Amomongo):
		creature = $Navigation2D/Amomongo
		creature.can_move = false
		creature_involved = true
	if is_instance_valid($Camera2D):
		camera = $Camera2D
		camera_involved = true
		player_camera = player.get_node("Camera2D")
		original_camera_position = $Camera2D.position
		print($Camera2D.position)
	if is_instance_valid($Dialogue):
		print("DIA")
		dialogue = $Dialogue
		dialogue_involved = true
	

func _physics_process(delta):
	if on_scene:
		pan_camera()
	
	
func _on_CutsceneTrigger_area_entered(area):
	if creature_involved:
		creature.can_move = true
	if camera_involved:
		$Camera2D.global_position = player_camera.global_position
		$Camera2D.current = true
		on_scene = true
	if dialogue_involved:
		dialogue.in_cutscene = true
		dialogue.start()
	player.can_move = false


func pan_camera():
	if $Camera2D.position.y > original_camera_position.y:
		$Camera2D.position.y -= PAN_SPEED
	

func return_camera():
	player_camera.current = true
	player.can_move = true


func _on_Dialogue_dialogue_finish():
	player.can_move = true
	collision.disabled = true
	if return_camera_after_dialogue:
		return_camera()
	

func _on_Amomongo_scene_over():
	collision.disabled = true
	player.can_move = true
	return_camera()
	


func _on_Timer_timeout():
	return_camera()
