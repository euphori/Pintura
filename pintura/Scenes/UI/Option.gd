extends Control

export (int) var index


func _on_Button_mouse_entered():
	get_parent().index_set(index)
	$Sprite.visible = true
	
	

func _on_Button_mouse_exited():
	$Sprite.visible = false


func _on_Button_pressed():
	#print("Button Index: " + String(index))
	get_parent().index_set(index)
	#print("Pressed " + String(get_parent().index_get()))
	
