extends KinematicBody2D

export var JUMP_HEIGHT = 940
export var ACCELERATION = 250
export var MAX_SPEED = 70
export var GRAVITY = 700
export var AIR_RESISTANCE = 0.02
export var FRICTION = .25
export var MAX_HEALTH = 100
export var ARMOR = 50
export var MAX_DISTANCE = 100

export(NodePath) var path_to_player


var motion = Vector2()
var invincible = false
var knockback = Vector2.ZERO
var player_detected = false
var state = IDLE
var health
var torch_is_on 
var flee_duration = 2
var time_set = false

onready var player = get_node(path_to_player)
onready var wander_controller = $WanderController
onready var aggro_range = $PlayerDetection/CollisionShape2D


enum{
	
	IDLE,
	WANDER,
	CHASE,
	CREEP,
	FLEE
	
}

func _ready():
	health = MAX_HEALTH

func _physics_process(delta):
	
	update_aggro_range()
	match state:
		IDLE:
			var direction = (player.global_position - global_position).normalized()
			var distance = global_position - player.global_position
			if distance >= Vector2(200,200):
				state = CREEP
			if wander_controller.get_time_left() == 0:
				state = pick_random_state([IDLE,WANDER])
				wander_controller.set_wander_timer(rand_range(1,9))
			motion = lerp(motion, Vector2.ZERO , FRICTION)
		CHASE:
			
			var direction = (player.global_position - global_position).normalized()
			var distance = global_position - player.global_position
			if distance >= Vector2(20,20) or distance <= Vector2(-20,-20):
				motion = motion.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				motion = Vector2.ZERO
				
			if distance >= Vector2(MAX_DISTANCE,MAX_DISTANCE):
				state = CREEP
		WANDER:
			var direction 
			var distance = global_position - player.global_position
			if distance >= Vector2(200,200):
				state = CREEP
			if wander_controller.get_time_left() == 0:
				#print("STATE: WANDER")
				state = pick_random_state([IDLE,WANDER])
				wander_controller.set_wander_timer(rand_range(1,9))
				
			direction = global_position.direction_to(wander_controller.target_position)
			motion = motion.move_toward(direction * MAX_SPEED, ACCELERATION * delta )
			
			if global_position.distance_to(wander_controller.target_position) <= 4:
				state = pick_random_state([IDLE,WANDER])
				wander_controller.set_wander_timer(rand_range(1,9))
		CREEP:
			print("CREEP")
			var direction = (player.global_position - global_position).normalized()
			var distance = global_position - player.global_position
			if distance >= Vector2(200,200):
				motion = motion.move_toward(direction * (MAX_SPEED/2), (ACCELERATION/2) * delta)
			else:
				state = IDLE
		FLEE:
			var direction = ( global_position - player.global_position ).normalized()
			var distance = global_position - player.global_position
			motion = motion.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			if time_set == false:
				set_flee_timer()
				
			
	if motion < Vector2.ZERO:
		$AnimatedSprite.flip_h = true
	elif motion > Vector2.ZERO:
		$AnimatedSprite.flip_h = false

	motion = move_and_slide(motion)

func update_aggro_range():
	var light_strength = player.torch.light_source_get()
	
	if torch_is_on:
		aggro_range.scale = Vector2(15+light_strength,15+light_strength)
		MAX_DISTANCE = 300
	elif torch_is_on == false:
		aggro_range.scale = Vector2(2,2)
		MAX_DISTANCE = 50

func pick_random_state(state_list):
	print("Picking Random State")
	state_list.shuffle()
	return state_list.pop_front()


func _on_PlayerDetection_body_entered(body):
	print("CHASE")
	state = CHASE
	player_detected = true


func _on_Player_toggle_torch():
	if player.torch.visible == true:
		torch_is_on = true
	else:
		torch_is_on = false


func set_flee_timer():
	$FleeTimer.start(flee_duration)
	time_set = true

func _on_FleeTimer_timeout():
	state = CREEP
	time_set = false
