extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = "res://Scenes/Structures/FarmHouse.tscn"
	loadObject()


#func _ready():
#	#previewBuilding = preload("res://Scenes/Structures/Barracks.tscn").instance()
#	spriteName = "FarmHouse"
#	if GlobalVariable.Friendly:
#		$FarmHouseControl.show()
#	pass
#
#func addPreview():
#	previewBuilding = preload("res://Scenes/Structures/FarmHouse.tscn").instance()
#	add_child(previewBuilding)
#	previewBuilding.hide()
#
#func build():
#	var newBuilding = load("res://Scenes/Structures/FarmHouse.tscn").instance()
#	var res=GlobalVariable.VikingRts.resources
#	if(Input.is_action_just_released("leftClick") && placeableBuilding == true):
#		newBuilding.buildingPlaced = true
#		var mousePos = get_global_mouse_position()
#		newBuilding.position = mousePos
#		newBuilding.add_to_group("Building")
#		res.wood-=40
#		get_tree().current_scene.get_node("Structures").add_child(newBuilding)
#		buildingMode = !buildingMode 
