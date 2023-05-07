extends Control

var page 

onready var player = get_owner().get_owner()
onready var page_slots = $PageContainer.get_children()
onready var page_count = $PageContainer.get_child_count()
onready var inventory = get_parent().get_node("Inventory")
onready var save_file = SaveFile.game_data
onready var quest_page = $PageContainer/QuestPage

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
			page = 1
			update_page()
			show_quest_list()
			initialize_quest_page()
			visible = true
		else:
			inventory.visible = true
			visible = false
	
	if event.is_action_pressed("ui_cancel"): 
		if visible == true:
			visible = false
		else:
			page = 0
			update_page()
			visible = true


func show_quest_list():
	match player.location:
		"Museum":
			quest_page.get_node("Museum").visible = true
			quest_page.get_node("Islands").visible = false
			quest_page.get_node("SideQuest").visible = false
		"WorldMap":
			quest_page.get_node("Museum").visible = false
			quest_page.get_node("Islands").visible = true


func update_page():
	
	page_slots[page].visible = true
	for i in page_count:
		if i != page:
			page_slots[i].visible = false



func initialize_quest_page():
	var page1 = quest_page.get_node("Islands/Page1")
	var page2 = quest_page.get_node("Islands/Page2")
	for i in page1.get_child_count():
		match Globals.quest_island[page1.get_child(i).get_name()]:
			"undiscovered":
				page1.get_child(i).visible = false
			"ongoing":
				page1.get_child(i).visible = true
				if page1.get_child(i).get_child_count() != 0:
					page1.get_child(i).get_child(0).visible = false
			"finished":
				page1.get_child(i).visible = true
				if page1.get_child(i).get_child_count() != 0:
					page1.get_child(i).get_child(0).visible = true
			
	for i in page2.get_child_count():
		match Globals.quest_island[page2.get_child(i).get_name()]:
			"undiscovered":
				page2.get_child(i).visible = false
			"ongoing":
				if page2.get_child(i).get_child_count() != 0:
					page2.get_child(i).get_child(0).visible = false
			"finished":
				page2.get_child(i).visible = true
				if page2.get_child(i).get_child_count() != 0:
					page2.get_child(i).get_child(0).visible = true


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


func _on_Exit_Game_pressed():
	get_tree().quit()


func _on_Ency_pressed():
	page = 2
	update_page()
	



func _on_Inventory_pressed():
	page = 3
	update_page()
