extends Node2D

 
onready var player = $YSort/Player

func _ready():

	player.location = "Museum"

func _input(event: InputEvent) -> void: 
	if OS.is_debug_build() && event.is_action_pressed("debug_reset_scene"):
		get_tree().reload_current_scene.call_deffered()
