extends CanvasLayer

func change_scene(target: String, type: String = 'dissolve') -> void:
	if type == 'intro':
		transition_intro(target)
	else:
		transition_dissolve(target)
	

func _physics_process(delta):
	transform.x = Vector2(get_viewport().size.x / $Container.get_rect().size.x ,0)
	transform.y = Vector2(0,get_viewport().size.y / $Container.get_rect().size.y)


	
func transition_dissolve(target: String) -> void:
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("dissolve")
	
	
func transition_intro(target: String) -> void:
	$AnimationPlayer.play("intro")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(target)
	$AnimationPlayer.play("IntroBack")
