extends Control

var buildingMode
onready var previewBarrack = preload("res://Scenes/Structures/Barracks.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	buildingMode = !buildingMode 
	#print(buildingMode) 
	pass # Replace with function body.

func previewbuild():

	add_child(previewBarrack)
	var mousePos = get_global_mouse_position()
	previewBarrack.position = mousePos

func build():
	if(Input.is_action_just_pressed("leftClick")):
		var newBarrack = load("res://Scenes/Structures/Barracks.tscn").instance()
		add_child(newBarrack)
		print("bruh")
		var mousePos = get_global_mouse_position()
		newBarrack.position = mousePos
		buildingMode = !buildingMode 


func _input(event):
	
	if (buildingMode == true):
		build()
		previewbuild()
	pass # Replace with function body.
