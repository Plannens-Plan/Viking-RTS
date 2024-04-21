extends Node2D

onready var GlobalVariable = get_node("/root/GlobalVariables")

var unlimited = false
var ressourceAmmount = 500
var harvestAmmount = 50
var workTime = 0.1
var pickUp = 0 
var itemType = "wood"

func Work():
	var rngwood = RandomNumberGenerator.new()
	harvestAmmount = rngwood.randi_range(5,12)
	if harvestAmmount > ressourceAmmount:
		harvestAmmount = ressourceAmmount
		pickUp += harvestAmmount
		ressourceAmmount = 0
		$Image.texture = load("res://Assets/Images/Icons/tree.jpg")
	else:
		pickUp += harvestAmmount
		ressourceAmmount = ressourceAmmount-harvestAmmount


func _process(delta):
	if pickUp==0 && ressourceAmmount==0:
		queue_free()
