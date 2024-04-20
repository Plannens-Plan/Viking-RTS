extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Units/FriendlyUnitTypes/FriendlyArcher.tscn")
	unit = true
	unitType = "FriendlyArcher"

func _process(delta):
	if units.FriendlyArcher <= 0:
		$Button.disabled = true
	else:
		$Button.disabled = false
