extends KinematicBody2D

var speed = 100
var velocity = Vector2.ZERO
signal garlic_nearby
onready var tambal = get_node("/root/Forest/Tambal")

func _physics_process(delta):
	speed -= 3
	if speed <= 0:
		velocity = Vector2.ZERO
	move_and_collide(velocity.normalized()* speed * delta)
	


func _on_Timer_timeout():
	queue_free()


func _on_EnemyDetection_body_entered(body):
	tambal.state = tambal.FLEE
