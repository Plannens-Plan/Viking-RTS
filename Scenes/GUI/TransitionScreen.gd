extends CanvasLayer

func change_scene(target: String, type: String = 'dissolve') -> void:
	if type == 'intro':
		transition_intro(target)
	else:
		transition_dissolve(target)
	
	
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
