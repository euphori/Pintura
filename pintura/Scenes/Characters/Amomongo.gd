extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 100
export var FRICTION = 500
export var MAX_HEALTH = 100
export var ARMOR = 50
export var MAX_DISTANCE = 100

export(NodePath) var path_to_player
export(Array, NodePath)var destination_path = []

onready var agent = $NavigationAgent2D
onready var player = get_node(path_to_player)

var motion = Vector2()
var direction
var timer_set = false
var can_move = false
var got_item = false
var destination = []
var distance

signal scene_over


func _ready():
	$Sprite.frame = 74
	for i in range(destination_path.size()):
		destination.append("")
		destination[i] = get_node((destination_path[i]))
	if player.location == "Museum":
		agent.set_target_location(destination[1].global_position)


func _physics_process(delta):
	
	match player.location:
		"Museum":
			play_musuem_cutscene()
		"HiddenRoom":
			play_hiddenroom_cutscene()
	
	if can_move == true:
		motion = motion.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)
	motion = move_and_slide(motion)


func play_musuem_cutscene():

	if global_position.distance_to(destination[0].global_position) >=5 :
		if got_item:
			direction = global_position.direction_to(agent.get_next_location())
			if global_position.distance_to(destination[1].global_position) <= 15:
				disappear()
				emit_signal("scene_over")
				
		else:
			direction = (destination[0].global_position - global_position).normalized()
			
	else:
		if timer_set == false:
			got_item = true
			$Timer.start(2)
			timer_set = true
			can_move = false

func play_hiddenroom_cutscene():
	distance = global_position - destination[0].global_position
	if distance >= Vector2(5,5) or distance <= Vector2(-5,-5):
		if global_position - destination[0].global_position >= Vector2(-5,-5):
				disappear()
				emit_signal("scene_over")
		direction = (destination[0].global_position - global_position).normalized()


func disappear():
	$AnimationPlayer.play("explode")
	

func _on_Timer_timeout():
	can_move = true
