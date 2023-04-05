extends Sprite

onready var light = $Light2D
onready var timer = $Timer
onready var player = get_parent()
var light_source = 2
var light_deg = 5
var fuel_strength = 4


func _ready():
	if player.location == "Forest":
		var fuel =  get_tree().get_root().get_node("Forest").get_node("Fuel")
	

func reduce_light():
	light.scale.x = light_source
	light.scale.y = light_source

func add_light():
	light_source += fuel_strength
	print(light_source)
	if light_source > 3:
		light_source = 6
	light.scale.x = light_source
	light.scale.y = light_source
	
func _on_Timer_timeout():
	if light_source != 0:
		if $AnimatedSprite.visible == false:
			$AnimatedSprite.visible = true
		light_source -= .5
		reduce_light()
		timer.start(light_deg)
	else:
		$AnimatedSprite.visible = false
		timer.stop()
	

func _on_Player_hide_torch():
	if self.visible:
		visible = false
	else:
		visible = true
		timer.paused
	


func _on_Player_received_fuel():
	add_light()
