extends "res://Scripts/Creatures.gd"


var current_desti = 0
var remove = false
var save_file = SaveFile.game_data
export(String,"WorldMap") var location 
export(String, "Hiraya", "Mother", "Dancers") var char_name
export var important = false
var player_near = false

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
	if char_name == "Dancers":
		if Globals.helped_the_dancers:
			Globals.set_torch(true)
	if char_name == "Mother":
		if Globals.museum_ending:
			get_parent().get_node("NPC/CanvasLayer/AnimationPlayer").play("fade_to_black")
	can_move = true
	current_desti = 1
	remove = true

func back_to_menu():
	Load.load_scene(get_parent(),"res://Scenes/UI/Ending.tscn")

