extends Control

var buildingMode


func _on_Button_pressed():
	buildingMode = !buildingMode 
	#print(buildingMode) 
	pass # Replace with function body.

func _input(event):
	
	if (buildingMode == true):
		if(Input.is_action_just_pressed("leftClick")):
			var newBarrack = load("res://Scenes/Barracks.tscn").instance()
			#print("bruh")
			var mousePos = get_global_mouse_position()
			#var mousePosY = get_global_mouse_position().y
			newBarrack.position = mousePos
			#newBarrack.position = mousePosY
			var scene=get_tree().get_root().get_child(0)
			if scene.name=="GlobalVariables":
				scene=get_tree().get_root().get_child(1)
			
			scene.get_node("Barracks").add_child(newBarrack)
			buildingMode=!buildingMode
	pass # Replace with function body.
