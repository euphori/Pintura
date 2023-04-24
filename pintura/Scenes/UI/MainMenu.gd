extends Control


onready var save_file = SaveFile.game_data



func _ready():
	$MusicController.play_menu_sound()
	print(save_file.last_scene)




func _on_NewGame_pressed():
	SaveFile.reset_data()
	Load.load_scene(self,"res://Scenes/Maps/Museum.tscn")
	


func _on_Continue_pressed():

	SaveFile.load_data()
	if save_file.last_scene == null:
		print("NO SAVED GAME")
	Load.load_scene(self,save_file.last_scene)
	print("LAST SCENE")
	print(save_file.last_scene)


func _on_Exit_pressed():
	get_tree().quit()
