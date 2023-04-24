extends Node
onready var player = get_parent()
var bg_museum = load("res://Music/Music Of Something.mp3")
var bg_tunnel = load("res://Music/An Ancient King.mp3")
var bg_world_start = load("res://Music/An Ugly Heart But It does Beats.mp3")
var bgm_chased = load("res://Music/Chasing.mp3")
var bgm_calm = load("res://Music/calm.mp3")
var bgm_festive = load("res://Music/Festive.mp3")

var bgm_seashore = load("res://Music/Sound Effects/Calm Seashore.mp3")
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


