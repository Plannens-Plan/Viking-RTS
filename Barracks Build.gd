extends Control

var buildingMode

#var Barracks = load("res://Scenes/Barracks.tscn")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	buildingMode = !buildingMode 
	print(buildingMode) 
	pass # Replace with function body.

func _input(event):
	
	if (buildingMode == true):
		if(Input.is_action_just_pressed("leftClick")):
			var newBarrack = load("res://Scenes/Barracks.tscn").instance()
			print("bruh")
			var mousePos = get_global_mouse_position()
			#var mousePosY = get_global_mouse_position().y
			newBarrack.position = mousePos
			#newBarrack.position = mousePosY
			add_child(newBarrack)
	pass # Replace with function body.
