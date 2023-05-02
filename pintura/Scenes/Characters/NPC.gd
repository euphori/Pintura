extends "res://Scripts/Creatures.gd"


var current_desti = 0
var remove = false
var save_file = SaveFile.game_data
export(String,"WorldMap") var location 
export(String, "Hiraya", "Mother") var char_name
export var important = false

func _ready():
	if Globals.museum_ending and char_name == "Mother":
		$Dialogue.dialogue_file = "res://Dialogue/Json/mother_last.json"
	print(save_file.met_hiraya)
	Globals.met_hiraya = save_file.met_hiraya
	if important == true:
		$Exclaim.visible = true
	else:
		$Exclaim.visible = false

	despawn()

func _physics_process(delta):
	if !stationary:
		goto_destination(current_desti,remove)
	
func despawn():
	if save_file.met_hiraya == true and location == "WorldMap":
		if char_name == "Hiraya":
			print("POOF")
			queue_free()

func _on_Dialogue_dialogue_finish():
	print("FIN")
	$Exclaim.visible = false
	if char_name == "Hiraya":
		Globals.met_hiraya = true
		save_file.met_hiraya = true
	can_move = true
	current_desti = 1
	remove = true

