extends Node
onready var player = get_parent()
var bg_museum = load("res://Music/Music Of Something.mp3")
var bg_tunnel = load("res://Music/An Ancient King.mp3")
var bg_world_start = load("res://Music/An Ugly Heart But It does Beats.mp3")
var dialogue_sound = load("res://Music/Sound Effects/DialogueSound.mp3")
var MenuSound = load("res://Music/Sound Effects/MenuSound.wav")

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

func play_menu_sound():
	$Music.stream = MenuSound
	$Music.play()

