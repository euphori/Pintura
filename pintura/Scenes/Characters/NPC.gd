extends "res://Scripts/Creatures.gd"


var current_desti = 0
var remove = false
var save_file = SaveFile.game_data
export(String,"WorldMap") var location 

func _ready():
	Globals.met_hiraya = save_file.met_hiraya
	despawn()

func _physics_process(delta):
	if !stationary:
		goto_destination(current_desti,remove)
	


	
func despawn():
	if save_file.met_hiraya == true and location == "WorldMap":
		print("POOF")
		queue_free()

func _on_Dialogue_dialogue_finish():
	Globals.met_hiraya = true
	save_file.met_hiraya = true
	can_move = true
	current_desti = 1
	remove = true

