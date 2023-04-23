extends CanvasLayer

export(String,FILE, "*.json") var dialogue_file
export (NodePath) var path_to_player
export(NodePath) var path_to_todo
export (bool) var can_move_during_dialogue
export (bool) var can_move_after_dialogue = true
export (bool) var trigger_event_on_end
export (int) var quest
export (int) var page
export (bool) var add_to_note = false

var dialogue = []
var current_dialogue_id = 0
var dialogue_active = false
var in_cutscene = false
onready var message = $Control/NinePatchRect/Message
var player 
var todo_list
var choosing
signal dialogue_start
signal dialogue_finish

func _ready():
	if add_to_note:
		todo_list = get_node(path_to_todo)
	player = get_node(path_to_player)
	$Control/NinePatchRect.visible = false
	
func start():
	if dialogue_active:
		return
	if !can_move_during_dialogue:
		player.can_move = false
	player.get_node("UserInterface").visible = false
	$Control/NinePatchRect.visible = true
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
	if event.is_action_pressed("ui_accept") and !choosing:
		if dialogue[current_dialogue_id].has("has_options") == true:
			choosing = true
			if Input.is_action_just_pressed("ui_accept"):
				var first = dialogue[current_dialogue_id+1]['text']
				var second = dialogue[current_dialogue_id+2]['text']
				show_options(first,second)
		else:
			next_line()
		
func next_line():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		if add_to_note:
			todo_list.show_quest(page,quest)
		$Control/Timer.start()
		$Control/NinePatchRect.visible = false
		current_dialogue_id = 0
		if can_move_after_dialogue:
			player.can_move = true
		player.get_node("UserInterface").visible = true
		emit_signal("dialogue_finish")
		return
	else:
		var speaker = dialogue[current_dialogue_id]['name']
		$Control/NinePatchRect/Sprite.texture = load("res://Assets/Textures/Portrait/"+ speaker + ".png")
		$Control/NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
		$Control/NinePatchRect/Message.text = dialogue[current_dialogue_id]['text']
		message.animate_text()
		
	


func show_options(first,second):
	$Control/NinePatchRect/Message.text = ""
	$Control/OptionA.visible = true
	$Control/OptionB.visible = true
	$Control/OptionA/Text.text = first
	$Control/OptionB/Text.text = second

func respond():
	$Control/NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
	$Control/NinePatchRect/Message.text = dialogue[current_dialogue_id]['text']

func _on_Timer_timeout():
	dialogue_active = false



func _on_OptionA_pressed():
	print("OPT A")
