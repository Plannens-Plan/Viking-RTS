extends Control
var previewBarrackArea

var buildingMode
var kollision
onready var previewBarrack = preload("res://Scenes/Structures/Barracks.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(previewBarrack)
	pass # Replace with function body.



func _on_Button_pressed():
	buildingMode = !buildingMode 
	pass # Replace with function body.

func previewbuild():
	previewBarrack.set_visible(true)
	var mousePos = get_global_mouse_position()
	previewBarrack.position = mousePos
	
	for area in previewBarrack.get_overlapping_areas():
		if previewBarrackArea and previewBarrackArea.is_in_group("unit"):
			print("BRRRRRUUUU")
			#var previewBarrackArea = previewBarrack.get_overlapping_areas()
	




func build():
	if(Input.is_action_just_released("leftClick")):
		var newBarrack = load("res://Scenes/Structures/Barracks.tscn").instance()
		add_child(newBarrack)
		newBarrack.buildingPlaced = true
		var mousePos = get_global_mouse_position()
		newBarrack.position = mousePos
		newBarrack.add_to_group("Building")
		buildingMode = !buildingMode 


func _input(event):
	if (buildingMode == true):
		build()
		previewbuild()
	pass # Replace with function body.
