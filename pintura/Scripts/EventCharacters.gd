extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 100
export var FRICTION = 500
export var MAX_HEALTH = 100
export var ARMOR = 50
export var MAX_DISTANCE = 100

export(NodePath) var path_to_player
export(Array, NodePath)var destination_path = []
export(bool) var stationary


onready var player = get_node(path_to_player)
onready var dialogue = get_node("Dialogue")

var motion = Vector2()
var can_move = false
var direction
var timer_set = false
var got_item = false
var destination = []
var distance
var player_near = false

signal scene_over

func _ready():
	$Sprite.frame = 74
	for i in range(destination_path.size()):
		destination.append("")
		destination[i] = get_node((destination_path[i]))


func _input(event):
	if event.is_action_pressed("interact") and player_near:
		dialogue.start()


func _physics_process(delta):
	
	if can_move == true:
		motion = motion.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)
	motion = move_and_slide(motion)
	
func go_to_destination(desti_index):
	var arrived
	direction = (destination[desti_index].global_position - global_position).normalized()
	if global_position.distance_to(destination[desti_index].global_position) <= 2:
		can_move = false
		arrived = true
	return arrived

