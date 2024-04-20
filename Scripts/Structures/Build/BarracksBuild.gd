extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Structures/Barracks.tscn")
	structure = true
	previewWoodCost = 200
	previewStoneCost = 100
	previewFoodCost = 0
	previewSilverCost = 0

func _process(delta):
	if resources.wood < previewWoodCost or resources.stone < previewStoneCost or resources.food < previewFoodCost or resources.silver < previewSilverCost:
		$Button.disabled = true
	else:
		$Button.disabled = false
