extends "res://Scripts/EventCharacters.gd"



onready var agent = $NavigationAgent2D
func _ready():
	$Sprite.frame = 74
	if player.location == "Museum":
		agent.set_target_location(destination[1].global_position)


func _physics_process(delta):
	
	match player.location:
		"Museum":
			play_musuem_cutscene()
		"HiddenRoom":
			play_hiddenroom_cutscene()



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
