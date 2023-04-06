extends Node2D

onready var torch = get_node("/root/Forest/YSort/Player/Torch")


func _on_Area2D_area_entered(area):
	queue_free()
	torch.add_light()
