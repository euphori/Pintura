extends Node2D

var page = 0
onready var max_page = $PageContainer.get_child_count() - 1
onready var page_slots = $PageContainer.get_children()


func _ready():
	page_slots[0].visible = true


func _input(event):
	if event.is_action_pressed("journal"):
		if visible == false:
			visible = true
		else:
			visible = false



func update_page():
	
	page_slots[page].visible = true
	for i in max_page + 1:
		if i != page:
			page_slots[i].visible = false
	
	


func _on_ButtonLeft_pressed():
	if page > 0:
		page -= 1
		print(page)
		update_page()


func _on_ButtonRight_pressed():
	if page < max_page:
		page += 1
		print(page)
		update_page()
