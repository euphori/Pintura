extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 100
export var FRICTION = 500
export var MAX_HEALTH = 100
export var ARMOR = 50
export var MAX_DISTANCE = 100

export(NodePath) var path_to_player
export(Array, NodePath)var destination_path = []
export var stationary = true
export var can_move = false

onready var agent = $NavigationAgent2D
onready var player = get_node(path_to_player)

var motion = Vector2()
var direction
var timer_set = false
var got_item = false
var destination = []
var distance


func _ready():
	for i in range(destination_path.size()):
		destination.append("")
		destination[i] = get_node((destination_path[i]))

func _physics_process(delta):
	
	if can_move == true and !stationary:
		motion = motion.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)
	motion = move_and_slide(motion)


func goto_destination(desti_index,remove:bool):
	distance = global_position.distance_to(destination[desti_index].global_position)
	print(distance)
	if distance >= 10:
		direction = (destination[desti_index].global_position - global_position).normalized()
	else:
		if remove:
			queue_free()
		can_move = false
	
