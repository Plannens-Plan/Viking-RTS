extends "res://Scripts/Structures/FriendlyStructure.gd"

var buildingPlaced = true
var scene

func _ready():
	scene = get_tree().current_scene

func _physics_process(delta):
	if selected:
		scene.get_node("GUI").get_node("TradeMap").show()
