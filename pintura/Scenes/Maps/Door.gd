extends StaticBody2D

export(String, FILE, "*.tscn,*.scn") var next_scene setget set_file_path
export (bool) var need_key
export (bool) var need_switch
export(String, "MuseumKey") var key_id


var player_near = false
var switch_on = false
var has_key = false

func set_file_path(p_value):
	if typeof(p_value) == TYPE_STRING and p_value.get_extension() in ["tscn", "scn"]:
		var d = Directory.new()
		if not d.file_exists(p_value):
			return
		next_scene = p_value


func check_requirement():
	for i in range(PlayerInventory.inventory.size()):
		if PlayerInventory.inventory[i].has(key_id):
			has_key = true
	return has_key

func _input(event):
	if event.is_action_pressed("interact") and player_near:
		if need_key:
			if check_requirement() == true:
				get_tree().change_scene(next_scene) #change scene
			else:
				$Dialogue.start()
		if need_switch and !switch_on:
			return
		else:
			get_tree().change_scene(next_scene)


func _on_Lamp_trigger_switch():
	switch_on = true
