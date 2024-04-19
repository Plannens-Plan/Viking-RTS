extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Structures/FarmHouse.tscn")
	structure = true
	if GlobalVariable.Friendly:
		$FarmHouseControl.show()
