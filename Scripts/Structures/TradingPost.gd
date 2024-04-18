extends "res://Scripts/Structures/FriendlyStructure.gd"

var buildingPlaced = true


func _ready():
	pass

func _input(event):
	if mouseOver == true && event.is_action_pressed("leftClick"):
		$TradeMap.show()
	if mouseOver == false && event.is_action_pressed("leftClick") && $TradeMap.mouseOver != true:
		$TradeMap.hide()
