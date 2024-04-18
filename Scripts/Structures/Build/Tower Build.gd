extends "res://Scripts/Structures/Build/BaseStructureBuild.gd"



func _ready():
	#previewBuilding = preload("res://Scenes/Structures/Tower.tscn").instance()
	spriteName="Tower"
	pass

func addPreview():
	previewBuilding = preload("res://Scenes/Structures/Tower.tscn").instance()
	previewBuilding.buildingPlaced = false
	add_child(previewBuilding)
	previewBuilding.hide()

func build():
	var newBuilding = load("res://Scenes/Structures/Tower.tscn").instance()
	var res=GlobalVariable.VikingRts.resources
	if(Input.is_action_just_released("leftClick") && placeableBuilding == true):
		newBuilding.buildingPlaced = true
		newBuilding.friendly = true
		var mousePos = get_global_mouse_position()
		newBuilding.position = mousePos
		newBuilding.add_to_group("Building")
		res.wood-=40
		get_tree().current_scene.get_node("Structures").add_child(newBuilding)
		buildingMode = !buildingMode 
