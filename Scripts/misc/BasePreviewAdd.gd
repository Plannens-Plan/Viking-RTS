extends Control

onready var previewShower = preload("res://Scenes/misc/PreviewShower.tscn")
onready var GlobalVariable = get_node("/root/GlobalVariables")

onready var units = GlobalVariable.VikingRts.units

var object
var structure = false
var unit = false

var unitType

func _on_Button_pressed():
	units[unitType] -= 1
	loadPreview()

func loadPreview():
	var previewShowerInst = previewShower.instance()
	previewShowerInst.shownObject = object
	previewShowerInst.sprite = object.instance().get_node("Sprite").texture
	previewShowerInst.spriteWidth = object.instance().get_node("Sprite").scale.x
	previewShowerInst.spriteHeight = object.instance().get_node("Sprite").scale.y
	previewShowerInst.collisionScaleX = object.instance().get_node("CollisionShape2D").shape.extents.x
	previewShowerInst.collisionScaleY = object.instance().get_node("CollisionShape2D").shape.extents.y
	print(previewShowerInst.collisionScaleY)
	previewShowerInst.previewingStructure = structure
	previewShowerInst.previewingUnit = unit
	var world = get_tree().current_scene
	world.add_child(previewShowerInst)

#extends Control
#
#var buildingMode
#var kollision
#
#
#var previewBuilding
##Override i _ready() previewBuilding med preload ligesom = preload("res://Scenes/Structures/Barracks.tscn").instance()
#
#var placeableBuilding 
#
##Override i _ready() med spritens navn
#var spriteName
#
#func addPreview():
#
#	add_child(previewBuilding)
#	previewBuilding.hide()
#
#func _on_Button_pressed():
#	addPreview()
#	buildingMode = !buildingMode 
#	pass # Replace with function body.
#
#func previewbuild():
#	#add_child(previewBuilding)
#	previewBuilding.set_visible(true)
#	var mousePos = get_global_mouse_position()
#	previewBuilding.position = mousePos
#
#	var overlapping = false
#	var sprite = previewBuilding.get_node("Sprite")
#	if previewBuilding is Area2D:
#		for area in previewBuilding.get_overlapping_areas():
#			if area.is_in_group("Building") || area.is_in_group("Terrain"):
#				placeableBuilding = false
#				sprite.modulate = Color(1, 0, 0)
#				overlapping = true
#		if not overlapping:
#				placeableBuilding = true
#				sprite.modulate = Color(0, 1, 0)
#
#	else:
#		var previewArea
#		previewArea = previewBuilding.get_node("PreviewArea")
#		for area in previewArea.get_overlapping_areas():
#			if area.is_in_group("Building") || area.is_in_group("Terrain"):
#				placeableBuilding = false
#				sprite.modulate = Color(1, 0, 0)
#				overlapping = true
#		if not overlapping:
#				placeableBuilding = true
#				sprite.modulate = Color(0, 1, 0)
#
#
#
##Hele funktionene skal overrides
#func build():
#	var newBuilding
#	var res=GlobalVariable.VikingRts.resources
#	if(buildingMode && Input.is_action_just_released("leftClick") && placeableBuilding == true):
#		newBuilding.buildingPlaced = true
#		var mousePos = get_global_mouse_position()
#		newBuilding.position = mousePos
#		newBuilding.add_to_group("Building")
#		res.wood-=40
#		get_tree().current_scene.get_node("Structures").get_node("Friendly").add_child(newBuilding)
#		buildingMode = !buildingMode 
#
#	if(Input.is_action_just_released("rightClick")):
#		buildingMode = !buildingMode 
#		print("akfhbaehkiteqtqwer")
#
#func notBuild():
#	if(Input.is_action_just_released("rightClick")):
#		previewBuilding.set_visible(false)
#		previewBuilding.queue_free()
#		buildingMode = !buildingMode 
#		print("akfhbaehkiteqtqwer")
#
#func _input(event):
#	var res=GlobalVariable.VikingRts.resources
#	if (buildingMode == true && res.wood >= 40):
#		build()
#		notBuild()
#		previewbuild()
