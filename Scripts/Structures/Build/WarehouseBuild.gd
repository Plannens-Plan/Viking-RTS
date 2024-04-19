extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Structures/Warehouse.tscn")
	structure = true
	previewWoodCost = 150
	previewStoneCost = 150
	previewFoodCost = 0
	previewSilverCost = 50
	if GlobalVariable.Friendly:
		$WarehouseCanvasLayer.show()
