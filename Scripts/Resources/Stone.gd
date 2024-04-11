extends Node2D
onready var GlobalVariable= get_node("/root/GlobalVariables")

var unlimited=false
var ressourceAmmount = 500
var harvestAmmount

func _on_Click_pressed():
	Work()


func Work():
	var rngwood=RandomNumberGenerator.new()
	harvestAmmount=rngwood.randi_range(3,8)
	if harvestAmmount>ressourceAmmount:
		GlobalVariable.VikingRts.resources.stone+=ressourceAmmount
		print(GlobalVariable.VikingRts.resources.stone)
	else:
		GlobalVariable.VikingRts.resources.stone+=harvestAmmount
		print(GlobalVariable.VikingRts.resources.stone)
		print("stone")
