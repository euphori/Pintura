extends CanvasLayer

export(String,FILE, "*.json") var dialogue_file
export (bool) var can_move_during_dialogue
export (bool) var can_move_after_dialogue = true
export (NodePath) var path_to_player

var dialogue = []

var choosing
var current_dialogue_id = 0
var dialogue_active = false
var in_cutscene = false
var dia_options = []

onready var message = $NinePatchRect/Message
var player 
signal dialogue_start
signal dialogue_finish

func _ready():
	visible = true
	player = get_node(path_to_player)
	$NinePatchRect.visible = false
	
func start():
	print(current_dialogue_id)
	if dialogue_active:
		return
	if !can_move_during_dialogue:
		player.can_move = false
	player.get_node("UserInterface").visible = false
	$NinePatchRect.visible = true
	dialogue_active = true
	dialogue = load_dialogue()
	
	current_dialogue_id -= 1
	emit_signal("dialogue_start")
	
	next_line()
	

func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())

func _input(event):
	if not dialogue_active:
		return
	if event.is_action_pressed("ui_accept"):
		if !choosing:
			next_line()
		
func next_line():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogue):
		finish_dialogue()
		return
	else:
		if dialogue[current_dialogue_id].has('options'):
			$DialogueOptions.visible = true
			show_options()
			choosing = true
		var speaker = dialogue[current_dialogue_id]['name']
		$NinePatchRect/Sprite.texture = load("res://Assets/Textures/Portrait/"+ speaker + ".png")
		$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
		$NinePatchRect/Message.text = dialogue[current_dialogue_id]['text']
		message.animate_text()
		

func finish_dialogue():
	$Timer.start()
	$NinePatchRect.visible = false
	current_dialogue_id = 0
	if can_move_after_dialogue:
		player.can_move = true
	player.get_node("UserInterface").visible = true
	emit_signal("dialogue_finish")

func show_options():
	for i in dialogue[current_dialogue_id]['options']:
				$DialogueOptions.get_child(i).visible = true
				$DialogueOptions.get_child(i).get_node("Label").text = dialogue[current_dialogue_id]['opt_' + String(i+1)]
	
func respond(ind):
	$NinePatchRect/Message.text = dialogue[current_dialogue_id+1]['opt_' + String(ind+1)]
	message.animate_text()


func _on_Timer_timeout():
	dialogue_active = false


func _on_Button_pressed():
	var index = $DialogueOptions.index_get()
	if index == 2:
		next_line()
		choosing = false
		$DialogueOptions.visible = false
	else:
		respond(index)
		choosing = false
		$DialogueOptions.visible = false
		



