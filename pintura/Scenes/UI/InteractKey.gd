extends Area2D


export (bool) var ylang = false
export (bool) var mosquito = false

export (String, "Open", "Talk", "Toggle", "Grab", "Exit", "Interact", "Push", "Harvest Ylang-Ylang", "Use Extract") var text


func _ready():

	$Label.text = text
	$AnimationPlayer.play("bob")


func _on_InteractKey_area_entered(area):
	if get_parent().get_name() == "Door":
		if get_parent().switch_on == false and get_parent().need_switch == true:
			visible = false
		else:
			visible = true
	else:
		visible = true
	if get_parent().get("player_near") != null:
		print("IS PLAYER NEAR:")
		print(get_parent().get("player_near"))
		get_parent().player_near = true

func _input(event):
	if event.is_action_pressed("interact") and get_parent().get("player_near") and get_parent().get_name() != "Door":
		if get_parent().get_node("Dialogue") != null:
			use_dialogue()
		visible = false
		if ylang:
			PlayerInventory.add_item("YlangOilExtract",1)
			self.queue_free()
		if mosquito:
			for i in range(PlayerInventory.inventory.size()):
				if PlayerInventory.inventory[i].has("YlangOilExtract"):
					
					get_node("/root/WorldMap/YSort/NPCs/Dancer/Dialogue").dialogue_file = "res://Dialogue/Json/dancers_after.json"
					get_parent().queue_free()
					Globals.set_helped_dancers(true)
			
			

func use_dialogue():
	var dialogue = get_parent().get_node("Dialogue")
	
	if dialogue:
		dialogue.start()


func _on_InteractKey_area_exited(area):
	visible = false
	if get_parent().get("player_near") != null:
		get_parent().player_near = false


