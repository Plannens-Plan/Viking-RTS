extends Node2D
onready var GlobalVariable= get_node("/root/GlobalVariables")

var unlimited=false
var ressourceAmmount = 500
var harvestAmmount = 10

func Work():
	var rngwood=RandomNumberGenerator.new()
	harvestAmmount=rngwood.randi_range(3,8)
	if harvestAmmount > ressourceAmmount:
		harvestAmmount = ressourceAmmount
		GlobalVariable.VikingRts.resources.stone += harvestAmmount
		print(GlobalVariable.VikingRts.resources.stone)
		ressourceAmmount = 0
	else:
		GlobalVariable.VikingRts.resources.stone+=harvestAmmount
		print(GlobalVariable.VikingRts.resources.stone)
		print("stone")
		ressourceAmmount = ressourceAmmount-harvestAmmount
