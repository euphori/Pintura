extends KinematicBody2D

var speed = 40
var accel = 190
var velocity = Vector2.ZERO

var cloud_png = [null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]

func _ready():
	for i in 19:
		cloud_png[i] = load("res://Assets/Textures/Environment/Clouds/Cloud " + str(i+1) + ".png")
		
	$Sprite.set_texture(cloud_png[round(rand_range(0,19))]) 
	self.scale.x = rand_range(1,3)
	self.scale.y = scale.x
	speed = rand_range(20,40)
	accel = rand_range(50,200)
func _physics_process(delta):
	
	velocity = velocity.move_toward(Vector2.RIGHT * speed,delta * accel)
	velocity = move_and_slide(velocity)
