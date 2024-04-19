extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Structures/Barracks.tscn")
	structure = true
	previewWoodCost = 200
	previewStoneCost = 100
	previewFoodCost = 0
	previewSilverCost = 0
	if GlobalVariable.Friendly:
		$BarrackBuild.show()
