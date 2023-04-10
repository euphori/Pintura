extends Node2D

var cloud = preload("res://Scenes/Objects/Cloud.tscn")


func _on_Timer_timeout():
	
	if round(rand_range(0,2)) == 1:
		print("Spawn Clouds")
		var cloud_instance = cloud.instance()
		add_child(cloud_instance)
		cloud_instance.position = $SpawnLocation.position
		var nodes = get_tree().get_nodes_in_group("spawn")
		var node = nodes[randi() % nodes.size()]
		var position = node.position
		$SpawnLocation.position = position
