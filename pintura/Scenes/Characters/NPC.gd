extends "res://Scripts/Creatures.gd"


var current_desti = 0
var remove = false

func _physics_process(delta):
	if !stationary:
		goto_destination(current_desti,remove)


func _on_Dialogue_dialogue_finish():
	can_move = true
	current_desti = 1
	remove = true
