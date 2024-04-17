extends Area2D

var buildingMode
var kollision
onready var previewFarmLand = preload("res://Scenes/Structures/FarmLand.tscn").instance()

var buildingPlaced = false
var placeableBuilding = true

onready var GlobalVariable = get_node("/root/GlobalVariables")

func previewbuild():
	add_child(previewFarmLand)
	previewFarmLand.set_visible(true)
	var mousePos = get_global_mouse_position()
	previewFarmLand.position = mousePos
	
	var overlapping = false
	var sprite = previewFarmLand.get_node("Farmland")
	for area in previewFarmLand.get_overlapping_areas():
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
		var newFarmLand = load("res://Scenes/Structures/FarmLand.tscn").instance()
		var mousePos = get_global_mouse_position()
		newFarmLand.position = mousePos
		newFarmLand.add_to_group("Building")
		res.wood-=40
		get_tree().current_scene.get_node("Structures").add_child(newFarmLand)
		previewFarmLand.queue_free()
		buildingMode = !buildingMode 

func _on_PurchaseFarmLand_pressed():
	var res=GlobalVariable.VikingRts.resources
	if (buildingMode == true && res.wood >= 40):
		build()
		previewbuild()
		print("briruehruet")
	pass # Replace with function body.

func _on_PurchaseMenu_pressed():
	buildingMode = !buildingMode 
	if buildingPlaced == true:
		$Panel.visible = !$Panel.visible
	pass # Replace with function body.
