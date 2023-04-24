extends Node


var bg_Music = load("res://Music/Music Of Something.mp3")
var bg_Tmusic = load("res://Music/An Ancient King.mp3")
var bg_Wmusic = load("res://Music/In Dreamlandbackground music.mp3")
var dialogue_Sound = load("res://Music/Sound Effects/DialogueSound.mp3")
var menu_Sound = load("res://Music/Sound Effects/MenuSound.wav")

func _ready():
	pass
	
func play_music():
	
	$Music.stream = bg_Music
	$Music.play()
	
func play_Tmusic():
	
	$Music.stream = bg_Tmusic
	$Music.play()
	
func play_Wmusic():
	
	$Music.stream = bg_Wmusic
	$Music.play()
	
func play_dialogue_Sound():
	$Music.stream = dialogue_Sound
	$Music.play()
	
func play_menu_Sound():
	$Music.stream = menu_Sound
	$Music.play()

