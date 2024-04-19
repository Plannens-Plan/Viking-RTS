extends "res://Scripts/Structures/FriendlyStructure.gd"

var buildingPlaced = true
var scene

func _ready():
	scene = get_tree().current_scene
	pass

func _input(event):
	if mouseOver == true && event.is_action_pressed("leftClick"):
		$TradeMap.show()
		if scene.has_node("GUI"):
			scene.get_node("GUI").hide()
			if scene.get_node("GUI").visible == false:
				print("buh")
	
	if mouseOver == false && event.is_action_pressed("leftClick") && $TradeMap.mouseOver != true:
		$TradeMap.hide()
