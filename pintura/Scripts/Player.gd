extends KinematicBody2D

var velocity = Vector2.ZERO
var SPEED = 100
var MAX_SPEED = 100
var FRICTION = 500
var ACCELERATION = 500
var location
var can_move = true
signal hide_torch

onready var camera = $Camera2D
onready var torch = $Torch
signal received_fuel


func _ready():
	pass
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
		emit_signal("hide_torch")
	

func _input(event):
	if event.is_action_pressed("inventory"):
		if $UserInterface/Inventory.visible == false:
			$UserInterface/Inventory.visible = true
		else:
			$UserInterface/Inventory.visible = false

func _on_Area2D_area_entered(area):
	emit_signal("received_fuel")

	
func _on_Interaction_body_entered(body):
	pass # Replace with function body.
