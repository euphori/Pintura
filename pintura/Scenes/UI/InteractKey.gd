extends Area2D



export (String, "Open", "Talk", "Toggle", "Grab", "Exit", "Interact") var text


func _ready():

	$Label.text = text
	$AnimationPlayer.play("bob")
	



