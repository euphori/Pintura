extends Node
onready var player = get_parent()
#BG Music
var bg_museum = load("res://Music/Music Of Something.mp3")
var bg_tunnel = load("res://Music/An Ancient King.mp3")
var bg_world_start = load("res://Music/An Ugly Heart But It does Beats.mp3")
var bgm_Chased = load("res://Music/Chasing.mp3")
var bgm_Calm = load("res://Music/calm.mp3")
var bgm_Festive = load("res://Music/Festive.mp3")
var  bgm_Seashore = load("res://Music/Sound Effects/Calm Seashore.mp3")



#Sound effects
var dialogue_Sound = load("res://Music/Sound Effects/DialogueSound.mp3")
#UI sound
var Menu_Sound = load("res://Music/Sound Effects/MenuSound.wav")

#Player Soundeffects
var museum_Steps = load("res://Music/Sound Effects/Steps_carpet-017.ogg")
var grass_Steps = load("res://Music/Sound Effects/Grass Footsteps.mp3")
var hurt_Sound = load("res://Music/Sound Effects/Hurt.wav")

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),Globals.get_volume())
	
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
	$Music.stream = Menu_Sound
	$Music.play()

