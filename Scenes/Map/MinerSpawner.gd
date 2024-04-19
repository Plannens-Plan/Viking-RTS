extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Units/FriendlyUnitTypes/FriendlyThrall.tscn")
	unit = true
	unitType = "thrall"
