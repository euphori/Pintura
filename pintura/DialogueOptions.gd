extends Control

var opt_index = 0 setget index_set, index_get
var num_options = 0



func _ready():
	for i in num_options:
		get_child(i).visible = false



func index_set(val):
	opt_index = val
	#print("NEW VALue: " + String(opt_index))

func index_get():
	return opt_index


