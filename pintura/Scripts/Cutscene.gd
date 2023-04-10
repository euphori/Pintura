extends Node2D


onready var player = get_node("/root/Museum/Player")
onready var player_camera =get_node("/root/Museum/Player/Camera2D")
onready var collision =  $CutsceneTrigger/CollisionShape2D



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

func _ready():
	if is_instance_valid($Navigation2D/Amomongo):
		creature = $Navigation2D/Amomongo
		creature.can_move = false
		creature_involved = true
	if is_instance_valid($Camera2D):
		camera = $Camera2D
		camera_involved = true
		original_camera_position = $Camera2D.position
		print($Camera2D.position)
	if is_instance_valid($Dialogue):
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
		print(original_camera_position.y)
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

func _on_Dialogue_dialogue_finish():
	player.can_move = true
	collision.disabled = true

func _on_Amomongo_scene_over():
	collision.disabled = true
	player.can_move = true
	return_camera()
	
