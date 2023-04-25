extends CanvasLayer

onready var label1 = $DialogueOptions/Option1/Label
onready var label2 = $DialogueOptions/Option2/Label
onready var label3 = $DialogueOptions/Option3/Label

func update_labels():
	print(get_parent().current_location)
	match get_parent().current_location:
		"Farm":
			label1.text = "Back to Main Island"
			label2.text = "Bailles de Luces"
			label3.text = "Forest"
		"Bailles de Luces":
			label1.text = "Back to Main Island"
			label2.text = "Farm"
			label3.text = "Forest"
		"Back to Main Island":
			label1.text = "Farm"
			label2.text = "Bailles de Luces"
			label3.text = "Forest"
		"Forest":
			label1.text = "Back to Main Island"
			label2.text = "Bailles de Luces"
			label3.text = "Farm"
