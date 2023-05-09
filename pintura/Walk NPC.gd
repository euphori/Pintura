extends KinematicBody2D

const speed = 30
var current_state = IDLE
var dir = Vector2.RIGHT

var start_pos


enum {
	IDLE,
	NEW_DIRE,
	MOVE
	SLEEP
}
func _ready():
	randomize()
	start_pos = position 



func _process(delta):
	
	if current_state == 0:
		$AnimatedSprite.play("idle")
	elif current_state == 1:
		$AnimatedSprite.play("idle")
	elif current_state == 2:
		$AnimatedSprite.play("walk")
	elif current_state == 3:
		$AnimatedSprite.play("sleep")
	
	match current_state:
		IDLE:
			pass
		NEW_DIRE:
			dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
		MOVE:
			move(delta)
		SLEEP:
			pass

func move(delta):
	if dir.x ==1:
		$AnimatedSprite.flip_h = false
	elif dir.x == -1:
		$AnimatedSprite.flip_h = true
	position += dir * speed * delta
	if position.x >= start_pos.x +3:
		position.x = start_pos.x + 2.9
	if position.x <= start_pos.x -3:
		position.x = start_pos.x - 2.9
	if position.y >= start_pos.y +3:
		position.y = start_pos.y + 2.9
	if position.y >= start_pos.y -3:
		position.y= start_pos.y - 2.9

func choose(array):
	array.shuffle()
	return array.front()

func _on_Timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1,5])
	current_state = choose([IDLE, NEW_DIRE, MOVE])
