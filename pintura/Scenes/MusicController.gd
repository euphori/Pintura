extends Node
onready var player = get_parent()
var bg_museum = load("res://Music/Music Of Something.mp3")
var bg_tunnel = load("res://Music/An Ancient King.mp3")
var bg_world_start = load("res://Music/In Dreamlandbackground music.mp3")

func _ready():
	pass
	
func play_music():
	match player.location:
		"Museum" , "HiddenRoom":
			$Music.stream = bg_museum
		"Tunnel":
			$Music.stream = bg_tunnel
		"WorldMap":
			$Music.stream = bg_world_start 
	$Music.play()


