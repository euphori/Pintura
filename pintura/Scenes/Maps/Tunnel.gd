extends Node2D

 
onready var player = $Player

func _ready():
	MusicController.play_Tmusic()
	player.location = "Tunnel"
