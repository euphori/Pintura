extends KinematicBody2D

export var ACCELERATION = 250
export var MAX_SPEED = 70

var velocity = Vector2(100,0)
var move_distance = 30
var can_move = false
var closing = false
var opening = false
onready var original_position = position.x



func _physics_process(delta):
	
	if opening:
		open(delta)
	if closing:
		close(delta)

func open(delta):
	if position.x >= original_position - move_distance:
			position -= velocity * delta
	

func close(delta):
	if position.x <= original_position:
			position += velocity * delta
	else:
		closing = false

func _on_Switch_trigger_switch():
	if !closing and !opening:
		print('X')
		opening = true
		closing = false
	elif opening:
		closing = true
		opening = false
