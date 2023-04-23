extends Node2D

export var hide_trees = true


# Called when the node enters the scene tree for the first time.
func _ready():
	if !hide_trees:
		$YSort/Trees.visible = true
