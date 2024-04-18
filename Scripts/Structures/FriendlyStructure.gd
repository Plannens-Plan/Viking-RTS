extends "res://Scripts/Structures/Structure.gd"

func _ready():
	outlineColor = Color(0, 1, 1, 1)
	friendly = true
	updateElements()

func _physics_process(delta):
	pass
