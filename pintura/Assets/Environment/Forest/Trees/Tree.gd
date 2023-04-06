extends StaticBody2D

var green = preload("res://Assets/Environment/Forest/Trees/green_birch.tres")
var yellow = preload("res://Assets/Environment/Forest/Trees/yellow_birch.tres")
var rng = RandomNumberGenerator.new()
onready var agent := GSAISteeringAgent.new()
func _ready():
	rng.randomize()
	var color = rng.randi_range(0,2)
	if color == 1:
		$Birch.set_texture(green)
	else:
		$Birch.set_texture(yellow)


