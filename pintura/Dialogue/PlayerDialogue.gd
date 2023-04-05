extends CanvasLayer

export(String,FILE, "*.json") var dialogue_file

var dialogue = []
var current_dialogue_id = 0
var dialogue_active = false
onready var message = $NinePatchRect/Message
onready var player = get_tree().get_root().get_node("Museum").get_node("Player")

func _ready():
	
	$NinePatchRect.visible = false
	
func start():
	if dialogue_active:
		return
	player.can_move = false
	$NinePatchRect.visible = true
	dialogue_active = true
	dialogue = load_dialogue()
	current_dialogue_id -= 1
	
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
		next_line()
		
func next_line():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogue):
		$Timer.start()
		$NinePatchRect.visible = false
		player.can_move = true
		current_dialogue_id = 0
		return
	else:
		
		$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
		$NinePatchRect/Message.text = dialogue[current_dialogue_id]['text']
		message.animate_text()
		
	

func _on_Timer_timeout():
	dialogue_active = false

