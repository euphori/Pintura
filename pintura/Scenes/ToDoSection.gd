extends Control

onready var max_page = $PageContainer.get_child_count() - 1
onready var page_slots = $PageContainer.get_children()
onready var quest_list = $PageContainer/Page


func _ready():
	pass
	
func show_quest(page,quest):
	var current_quest = page_slots[page].get_children()
	current_quest[quest].visible = true
