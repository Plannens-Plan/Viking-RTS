extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Structures/FriendlyTower.tscn")
	structure = true
	previewWoodCost = 250
	previewStoneCost = 50
	previewFoodCost = 100
	previewSilverCost = 50

func _process(delta):
	if resources.wood < previewWoodCost or resources.stone < previewStoneCost or resources.food < previewFoodCost or resources.silver < previewSilverCost:
		$Button.disabled = true
	else:
		$Button.disabled = false
