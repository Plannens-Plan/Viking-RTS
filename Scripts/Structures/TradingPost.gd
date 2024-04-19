extends "res://Scripts/Structures/FriendlyStructure.gd"

var buildingPlaced = true
var scene

func _ready():
	scene = get_tree().current_scene
	pass

func _process(delta):
	print(scene.get_node("GUI").get_node("TradeMap").visible)

func _input(event):
	if mouseOver == true && event.is_action_released("leftClick"):
			scene.get_node("GUI").get_node("TradeMap").show()
