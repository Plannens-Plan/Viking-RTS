extends "res://Scripts/misc/BasePreviewAdd.gd"


func _ready():
	object = load("res://Scenes/Units/FriendlyUnitTypes/FriendlySpearman.tscn")
	unit = true
	unitType = "FriendlySpearman"
	
func _process(delta):
	if units.FriendlySpearman <= 0:
		$Button.disabled = true
	else:
		$Button.disabled = false
