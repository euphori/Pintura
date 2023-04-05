extends RichTextLabel


func animate_text():
	$Tween.interpolate_property(self,"percent_visible",0.0,1.0,1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
