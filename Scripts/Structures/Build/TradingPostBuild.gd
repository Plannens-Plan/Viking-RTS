extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Structures/TradingPost.tscn")
	structure = true
	previewWoodCost = 200
	previewStoneCost = 0
	previewFoodCost = 50
	previewSilverCost = 50
	if GlobalVariable.Friendly:
		$TradingPostCanvasLayer.show()
