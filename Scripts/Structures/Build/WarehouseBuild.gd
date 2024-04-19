extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Structures/Warehouse.tscn")
	structure = true
	if GlobalVariable.Friendly:
		$FarmHouseCanvasLayer.show()
