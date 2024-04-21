extends Control

onready var previewShower = preload("res://Scenes/misc/PreviewShower.tscn")
onready var GlobalVariable = get_node("/root/GlobalVariables")

onready var units = GlobalVariable.VikingRts.units
onready var resources = GlobalVariable.VikingRts.resources

var object
var structure = false
var unit = false

var previewUnitType

var previewWoodCost = 0
var previewStoneCost = 0
var previewFoodCost = 0
var previewSilverCost = 0

func _on_Button_pressed():
	loadPreview()

func loadPreview():
	var world = get_tree().current_scene
	if world.get_node("Previews").get_child_count() > 0:
		world.get_node("Previews").get_child(0).queue_free()
	var previewShowerInst = previewShower.instance()
	previewShowerInst.shownObject = object
	previewShowerInst.sprite = object.instance().get_node("Sprite").texture
	previewShowerInst.spriteWidth = object.instance().get_node("Sprite").scale.x
	previewShowerInst.spriteHeight = object.instance().get_node("Sprite").scale.y
	previewShowerInst.spritePosition = object.instance().get_node("Sprite").position
	if object.instance().get_node("CollisionShape2D").shape is CircleShape2D:
		previewShowerInst.collisionScaleRadius = object.instance().get_node("CollisionShape2D").shape.radius
		previewShowerInst.collisionScaleX = null
		previewShowerInst.collisionScaleY = null
	if object.instance().get_node("CollisionShape2D").shape is RectangleShape2D:
		previewShowerInst.collisionScaleRadius = null
		previewShowerInst.collisionScaleX = object.instance().get_node("CollisionShape2D").shape.extents.x
		previewShowerInst.collisionScaleY = object.instance().get_node("CollisionShape2D").shape.extents.y
	previewShowerInst.previewingStructure = structure
	previewShowerInst.previewingUnit = unit
	if structure:
		previewShowerInst.woodCost = previewWoodCost
		previewShowerInst.stoneCost = previewStoneCost
		previewShowerInst.foodCost = previewFoodCost
		previewShowerInst.silverCost = previewSilverCost
	if unit:
		previewShowerInst.unitType = previewUnitType

	previewShowerInst.collisionPosition = object.instance().get_node("CollisionShape2D").position
	world.get_node("Previews").add_child(previewShowerInst)
