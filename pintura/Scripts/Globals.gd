extends Node

var world_player_position = Vector2.ZERO
var met_hiraya = false
var last_location
var helped_the_dancers = false
var has_torch
var has_garlic
var music_volume = 1 setget set_volume,get_volume

func set_volume(val):
	music_volume = val

func get_volume():
	return music_volume
