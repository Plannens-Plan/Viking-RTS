extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Units/FriendlyUnitTypes/FriendlyThrall.tscn")
	unit = true
	unitType = "FriendlyThrall"

func _process(delta):
	if units.FriendlyThrall <= 0:
		$Button.disabled = true
	else:
		$Button.disabled = false
