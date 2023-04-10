extends KinematicBody2D

var velocity = Vector2.ZERO
var SPEED = 100
var MAX_SPEED = 100
var FRICTION = 500
var ACCELERATION = 500
var location
var can_move = true
var MAX_ACCELERATION = 500
signal toggle_torch

onready var camera = $Camera2D
onready var torch = $Torch
onready var agent := GSAISteeringAgent.new()
onready var garlic_scene = preload("res://Scenes/Garlic.tscn")



func _physics_process(delta):
	var input_vector = Vector2.ZERO
	if can_move:
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x < 0:
			$Sprite.flip_h = true
		elif input_vector.x > 0:
			$Sprite.flip_h = false
		$AnimationPlayer.play("walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		$AnimationPlayer.stop()
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("light"):
		emit_signal("toggle_torch")
		
	

func _input(event):
	if event.is_action_pressed("inventory"):
		if $UserInterface/Inventory.visible == false:
			$UserInterface/Inventory.visible = true
		else:
			$UserInterface/Inventory.visible = false
	if event.is_action_pressed("throw"):
		throw()
		
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_RIGHT:
			self.global_position = get_global_mouse_position()
	

func throw():
	var garlic_path = garlic_scene
	var garlic = garlic_path.instance()
	var direction = (get_global_mouse_position() - $Position2D.global_position).normalized()
	get_parent().add_child(garlic)
	garlic.global_position = $Position2D.global_position
	garlic.velocity = direction * 50


func _on_Dialogue_dialogue_finish():
	$UserInterface/JournalIcon.get_player_attention()
