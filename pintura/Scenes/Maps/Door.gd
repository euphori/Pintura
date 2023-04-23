extends StaticBody2D

export(String, FILE, "*.tscn,*.scn") var next_scene setget set_file_path
export (bool) var need_key
export (bool) var need_switch
export(String, "MuseumKey") var key_id


var player_near = false
var switch_on = false


func set_file_path(p_value):
	if typeof(p_value) == TYPE_STRING and p_value.get_extension() in ["tscn", "scn"]:
		var d = Directory.new()
		if not d.file_exists(p_value):
			return
		next_scene = p_value


func _change_scene():
	Load.load_scene(get_owner(),next_scene)

func _input(event):
	
	if event.is_action_pressed("interact") and player_near:
		if need_key:
			for i in range(PlayerInventory.inventory.size()):
				print(PlayerInventory.inventory[i])
				if PlayerInventory.inventory[i].has(key_id):
					get_tree().change_scene(next_scene) #change scene
				else:
					$Dialogue.start()
		else:
			$CanvasLayer/AnimationPlayer.play("fade_to_black")
		if need_switch and !switch_on:
			return
		


func _on_Lamp_trigger_switch():
	switch_on = true


func _on_AnimationPlayer_animation_finished(anim_name):
	$CanvasLayer/AnimationPlayer.play("fade_to_normal")
