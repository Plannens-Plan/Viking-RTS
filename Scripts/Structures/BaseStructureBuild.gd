extends Control

var buildingMode
var kollision

#Override previewBuilding med preload ligesom = preload("res://Scenes/Structures/Barracks.tscn").instance()
onready var previewBuilding
var placeableBuilding

onready var GlobalVariable = get_node("/root/GlobalVariables")

#"Barrack"
var spriteName


#Override newBuilding med load path ligesom:  = load("res://Scenes/Structures/Barracks.tscn").instance()
var newBuilding



func _ready():


	add_child(previewBuilding)
	previewBuilding.hide()
	pass # Replace with function body.

func _on_Button_pressed():
	buildingMode = !buildingMode 
	pass # Replace with function body.

func previewbuild():
	previewBuilding.set_visible(true)
	var mousePos = get_global_mouse_position()
	previewBuilding.position = mousePos
	
	var overlapping = false
	var sprite = previewBuilding.get_node(spriteName)
	for area in previewBuilding.get_overlapping_areas():
		if area.is_in_group("Building") || area.is_in_group("Terrain"):
			placeableBuilding = false
			sprite.modulate = Color(1, 0, 0)
			overlapping = true
	if not overlapping:
			placeableBuilding = true
			sprite.modulate = Color(0, 1, 0)




func build():
	
	var res=GlobalVariable.VikingRts.resources
	if(Input.is_action_just_released("leftClick") && placeableBuilding == true):
		newBuilding.buildingPlaced = true
		var mousePos = get_global_mouse_position()
		newBuilding.position = mousePos
		newBuilding.add_to_group("Building")
		res.wood-=40
		get_tree().current_scene.get_node("Structures").add_child(newBuilding)
		buildingMode = !buildingMode 


func _input(event):
	var res=GlobalVariable.VikingRts.resources
	if (buildingMode == true && res.wood >= 40):
		build()
		previewbuild()
	pass # Replace with function body.