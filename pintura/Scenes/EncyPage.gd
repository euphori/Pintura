extends Control

onready var page_slots = $Pages.get_children()
onready var page_count = $Pages.get_child_count()
var page = 0

func update_page():
	page_slots[page].visible = true
	for i in page_count:
		if i != page:
			page_slots[i].visible = false


func _on_Left_pressed():
	if page > 0:
		page -= 1
	update_page()


func _on_Right_pressed():
	print(page_count)
	print(page)
	if page < page_count - 1:
		page += 1
	print(page)
	update_page()
