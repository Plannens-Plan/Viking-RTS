extends Control
var previewBarrackArea

var buildingMode
var kollision
onready var previewBarrack = preload("res://Scenes/Structures/Barracks.tscn").instance()

var placeableBuilding

onready var GlobalVariable = get_node("/root/GlobalVariables")

onready var toolTip = get_node("Tooltip")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(previewBarrack)
	previewBarrack.hide()
	pass # Replace with function body.



func _on_Button_pressed():
	buildingMode = !buildingMode 
	pass # Replace with function body.

func previewbuild():
	previewBarrack.set_visible(true)
	var mousePos = get_global_mouse_position()
	previewBarrack.position = mousePos
	
	var overlapping = false
	var sprite = previewBarrack.get_node("Barrack")
	for area in previewBarrack.get_overlapping_areas():
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
		var newBarrack = load("res://Scenes/Structures/Barracks.tscn").instance()
		add_child(newBarrack)
		newBarrack.buildingPlaced = true
		var mousePos = get_global_mouse_position()
		newBarrack.position = mousePos
		newBarrack.add_to_group("Building")
		res.wood-=40
		buildingMode = !buildingMode 


func _input(event):
	var res=GlobalVariable.VikingRts.resources
	if (buildingMode == true && res.wood >= 40):
		build()
		previewbuild()
	pass # Replace with function body.
