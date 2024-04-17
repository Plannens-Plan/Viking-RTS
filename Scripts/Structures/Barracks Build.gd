extends "res://Scripts/Structures/BaseStructureBuild.gd"


#Override previewBuilding med preload ligesom = preload("res://Scenes/Structures/Barracks.tscn").instance()
func _ready():
	previewBuilding = preload("res://Scenes/Structures/Barracks.tscn").instance()
	var spriteName = "Barracks"
	var newBuilding = load("res://Scenes/Structures/Barracks.tscn").instance()

#Override newBuilding med load path ligesom:  = load("res://Scenes/Structures/Barracks.tscn").instance()

