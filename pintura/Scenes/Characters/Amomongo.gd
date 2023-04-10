extends KinematicBody2D

export var ACCELERATION = 250
export var MAX_SPEED = 70
export var FRICTION = .25
export var MAX_HEALTH = 100
export var ARMOR = 50
export var MAX_DISTANCE = 100



onready var podium = get_node("/root/Museum/Podium")
onready var door = get_node("/root/Museum/DoorMuseum1")
onready var agent = $NavigationAgent2D

var motion = Vector2()
var direction
var timer_set = false
var can_move = false
var got_item = false

signal scene_over


func _ready():
	agent.set_target_location(door.global_position)


func _physics_process(delta):
	
	
	var distance = global_position - podium.global_position
	
	if distance >= Vector2(5,5) or distance <= Vector2(-5,-5):
		if got_item:
			direction = global_position.direction_to(agent.get_next_location())
			if global_position - door.global_position >= Vector2(-50,-50):
				queue_free()
				emit_signal("scene_over")
		else:
			direction = (podium.global_position - global_position).normalized()
			
	else:
		if timer_set == false:
			got_item = true
			$Timer.start(2)
			timer_set = true
			can_move = false
		
	if can_move == true:
		motion = motion.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		motion = Vector2.ZERO
	motion = move_and_slide(motion)


func _on_Timer_timeout():
	can_move = true
