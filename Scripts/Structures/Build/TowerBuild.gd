extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Structures/FriendlyTower.tscn")
	structure = true
	previewWoodCost = 250
	previewStoneCost = 50
	previewFoodCost = 100
	previewSilverCost = 50
	if GlobalVariable.Friendly:
		$TowerCanvasLayer.show()
