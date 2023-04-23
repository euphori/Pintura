extends Node2D




onready var collision =  $CutsceneTrigger/CollisionShape2D
export var path_to_player := NodePath()
export var return_camera_after_dialogue = false
export (bool) var can_move_after_dialogue
export (bool) var start_dialogue_on_entry = true
export (bool) var can_move_during_cutscene = false
export (String, "player_camera","creature_camera","scene_camera") var camera_used
export var dialogue_involved = false


onready var player = get_node(path_to_player)
onready var dialogue = get_node("Dialogue")

var on_scene = false
var end_scene = false
var creature_involved = false
var camera_involved = false
var creature
var camera
var timer_set = false
var original_camera_position
var player_camera
var todo_list

const PAN_SPEED = 3

func _ready():
	
	if is_instance_valid($Navigation2D/Amomongo):
		creature = $Navigation2D/Amomongo
		creature_involved = true
		player_camera = player.get_node("Camera2D")
		original_camera_position = $Camera2D.position
		match camera_used:
			"player_camera":
				camera = player_camera
			"creature_camera":
				if creature_involved:
					camera = $Navigation2D/Amomongo/Camera2D
			"scene_camera":
				camera = $Camera2D
			"default":
				camera = $Camera2D
		camera_involved = true


func _physics_process(delta):
	if on_scene:
		pan_camera()
	
	
func _on_CutsceneTrigger_area_entered(area):
	if camera_involved:
		camera.global_position = player_camera.global_position
		camera.current = true
		on_scene = true
	if dialogue_involved:
		if start_dialogue_on_entry:
			dialogue.start()
	if creature_involved:
		creature.can_move = true
	collision.set_deferred("disabled" ,true)
	if !can_move_during_cutscene:
		player.can_move = false


func pan_camera():
	if camera_used == "scene_camera":
		if camera.position.y > original_camera_position.y:
			camera.position.y -= PAN_SPEED
	

func return_camera():
	player_camera.current = true
	player.can_move = true




func _on_Dialogue_dialogue_finish():
	if can_move_after_dialogue:
		player.can_move = true
	collision.disabled = true
	if return_camera_after_dialogue:
		if !timer_set:
			$Timer.start(.5)
			timer_set = true
		




func _on_Amomongo_scene_over():
	collision.disabled = true
	player.can_move = true
	return_camera()
	
	


func _on_Timer_timeout():
	if camera_used == "player_camera":
		return_camera()
	timer_set = false
