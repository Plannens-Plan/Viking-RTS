extends Control

var buildingMode
var kollision
onready var previewFarm = preload("res://Scenes/Structures/FarmHouse.tscn").instance()

var placeableBuilding

onready var GlobalVariable = get_node("/root/GlobalVariables")

# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalVariable.Friendly:
		$FarmHouseControl.show()
		add_child(previewFarm)
		previewFarm.hide()
	
	pass # Replace with function body.

func _on_Button_pressed():
	buildingMode = !buildingMode 
	pass # Replace with function body.

func previewbuild():
	previewFarm.set_visible(true)
	var mousePos = get_global_mouse_position()
	previewFarm.position = mousePos
	
	var overlapping = false
	var sprite = previewFarm.get_node("FarmHouse")
	for area in previewFarm.get_overlapping_areas():
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
		var newFarm = load("res://Scenes/Structures/FarmHouse.tscn").instance()
		newFarm.buildingPlaced = true
		var mousePos = get_global_mouse_position()
		newFarm.position = mousePos
		newFarm.add_to_group("Building")
		res.wood-=40
		get_tree().current_scene.get_node("Structures").add_child(newFarm)
		buildingMode = !buildingMode 


func _input(event):
	var res=GlobalVariable.VikingRts.resources
	if (buildingMode == true && res.wood >= 40):
		build()
		previewbuild()
	pass # Replace with function body.
