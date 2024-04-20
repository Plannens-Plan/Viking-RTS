extends Control

onready var previewShower = preload("res://Scenes/misc/PreviewShower.tscn")
onready var GlobalVariable = get_node("/root/GlobalVariables")

onready var units = GlobalVariable.VikingRts.units

var resources

var object
var structure = false
var unit = false

var unitType

var previewWoodCost = 0
var previewStoneCost = 0
var previewFoodCost = 0
var previewSilverCost = 0

func _ready():
	resources = GlobalVariable.VikingRts.resources

func _on_Button_pressed():
	if structure == true:
		loadPreview()
	elif units[unitType] and units[unitType] > 0 and unit == true:
		units[unitType] -= 1
		loadPreview()

func loadPreview():
	var previewShowerInst = previewShower.instance()
	previewShowerInst.shownObject = object
	previewShowerInst.sprite = object.instance().get_node("Sprite").texture
	previewShowerInst.spriteWidth = object.instance().get_node("Sprite").scale.x
	previewShowerInst.spriteHeight = object.instance().get_node("Sprite").scale.y
	print(object.instance().get_node("CollisionShape2D").shape)
	if object.instance().get_node("CollisionShape2D").shape is CircleShape2D:
		previewShowerInst.collisionScaleRadius = object.instance().get_node("CollisionShape2D").shape.radius
		previewShowerInst.collisionScaleX = null
		previewShowerInst.collisionScaleY = null
	if object.instance().get_node("CollisionShape2D").shape is RectangleShape2D:
		print(object.instance().get_node("CollisionShape2D").shape)
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
	var world = get_tree().current_scene
	world.add_child(previewShowerInst)
