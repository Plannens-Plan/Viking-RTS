extends Sprite
func _input(event):
	if event.is_action_pressed("Test"):
		show()
	if event.is_action_released("Test"):
		hide()
