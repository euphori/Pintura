extends KinematicBody2D


onready var player = get_tree().get_root().get_node("Forest").get_node("YSort").get_node("Player")


export var JUMP_HEIGHT = 940
export var ACCELERATION = 512
export var MAX_SPEED = 50
export var GRAVITY = 700
export var AIR_RESISTANCE = 0.02
export var FRICTION = .25
export var MAX_HEALTH = 100
export var ARMOR = 50

var motion = Vector2()


func _physics_process(delta):
		var direction = (player.global_position - self.global_position)
		var distance = self.global_position - player.global_position

		motion += direction * ACCELERATION * delta
		motion = motion.clamped(MAX_SPEED)
		if motion.x < 0:
			$AnimatedSprite.flip_h = true
		elif motion.x > 0:
			$AnimatedSprite.flip_h = false
		motion = move_and_slide(motion)

	
