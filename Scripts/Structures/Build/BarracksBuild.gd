extends "res://Scripts/misc/BasePreviewAdd.gd"

func _ready():
	object = load("res://Scenes/Structures/Barracks.tscn")
	structure = true
	if GlobalVariable.Friendly:
		$BarrackBuild.show()
