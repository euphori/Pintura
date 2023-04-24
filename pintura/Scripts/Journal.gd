extends Control

var page 

onready var player = get_owner().get_owner()
onready var page_slots = $PageContainer.get_children()
onready var page_count = $PageContainer.get_child_count()
onready var inventory = get_parent().get_node("Inventory")
onready var save_file = SaveFile.game_data

signal toggle_journal

func _ready():
	page_slots[0].visible = true
	var grp = ButtonGroup.new()
	$Quest.group = grp
	$Ency.group = grp
	$Inventory.group = grp
	$Settings.group = grp


func _input(event):
	if event.is_action_pressed("journal"):
		emit_signal("toggle_journal")
		if visible == false:
			inventory.visible = false
			visible = true
		else:
			inventory.visible = true
			visible = false



func update_page():
	
	page_slots[page].visible = true
	for i in page_count:
		if i != page:
			page_slots[i].visible = false




func _on_Quest_pressed():
	page = 1
	update_page()

func _on_Settings_pressed():
	page = 0
	update_page()


func _on_Save_pressed():
	
	Globals.world_player_position = player.global_position
	save_file.world_player_position = Globals.world_player_position
	save_file.met_hiraya = Globals.met_hiraya
	save_file.last_scene = player.get_owner().filename
	save_file.last_location = player.location
	print(save_file.last_scene )
	SaveFile.save_data()
