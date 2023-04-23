extends Node2D

var page = 0
var section

onready var encyclopedia = $EncyclopediaSection
onready var todo = $ToDoSection
onready var inventory = get_parent().get_node("Inventory")

signal toggle_journal

func _ready():
	section = todo
	todo.page_slots[0].visible = true


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
	
	section.page_slots[page].visible = true
	for i in section.max_page + 1:
		if i != page:
			section.page_slots[i].visible = false
	

func update_section():
	match section:
		todo:
			todo.visible = true
			encyclopedia.visible = false
			$EncyclopediaButton.pressed = false
		encyclopedia:
			todo.visible = false
			encyclopedia.visible = true
			$ToDoButton.pressed = false

func _on_ButtonLeft_pressed():
	if page > 0:
		page -= 1
		update_page()


func _on_ButtonRight_pressed():
	if page < section.max_page:
		page += 1
		update_page()


func _on_ToDoButton_pressed():
	print("TODO")
	section = todo
	update_section()


func _on_EncyclopediaButton_pressed():
	print("ENCY")
	section = encyclopedia
	update_section()
