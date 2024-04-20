extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Units/FriendlyUnitTypes/FriendlyAxeman.tscn")
	unit = true
	unitType = "FriendlyAxeman"

func _process(delta):
	if units.FriendlyAxeman <= 0:
		$Button.disabled = true
	else:
		$Button.disabled = false
