extends StaticBody2D

export(String, FILE, "*.tscn,*.scn") var file_path setget set_file_path
export(NodePath) var spawn_from
export(NodePath) var path_to_player


var player_near = false

func set_file_path(p_value):
	if typeof(p_value) == TYPE_STRING and p_value.get_extension() in ["tscn", "scn"]:
		var d = Directory.new()
		if not d.file_exists(p_value):
			return
		file_path = p_value

func _input(event):
	if event.is_action_pressed("interact") and player_near:
		get_tree().change_scene(file_path) #change scene
