extends Sprite

var hint = true


func get_player_attention():
	if hint:
		$Label.visible = true
		hint = false
	$Exclamation.visible = true

func _on_Journal_toggle_journal():
	$Label.visible = false
	$Exclamation.visible = false
