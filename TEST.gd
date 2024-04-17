extends CanvasLayer
func _physics_process(delta):
	#print($Node2D.position)
	if Input.is_action_just_pressed("Test"):
		$Node2D.position=Vector2(500,500)
