extends "res://Scripts/Structures/Structure.gd"

func _ready():
	outlineColor = Color(1, 0, 0, 1)
	friendly = false
	updateElements()

func _physics_process(delta):
	pass
