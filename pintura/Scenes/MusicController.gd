extends Node


var bg_Music = load("res://Music/Music Of Something.mp3")
var bg_Tmusic = load("res://Music/An Ancient King.mp3")
var bg_Wmusic = load("res://Music/In Dreamlandbackground music.mp3")

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


