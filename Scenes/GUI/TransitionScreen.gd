extends CanvasLayer

var targetScene

func change_scene(target: String, type: String = 'dissolve') -> void:
	targetScene = target
	if type == 'intro':
		transition_intro(target)
	else:
		transition_dissolve(target)
	
	
func transition_dissolve(target: String) -> void:
#	self.show()
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("dissolve")
	
	
func transition_intro(target: String) -> void:
#	self.show()
	$AnimationPlayer.play("intro")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(target)
	$AnimationPlayer.play("IntroBack")


#func _input(event):
#	if event.is_action_pressed("Test") && $AnimationPlayer.is_playing() && $AnimationPlayer.assigned_animation == "intro":
#		$AnimationPlayer.clear_caches()
#		get_tree().change_scene(targetScene)

func _on_Skip_pressed():
	pass # Replace with function body.
