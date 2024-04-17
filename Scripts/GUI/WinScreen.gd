extends Control


onready var GlobalVariable= get_node("/root/GlobalVariables")
onready var remainingTroops = GlobalVariable.RemainingTroops
func _ready():
	print (remainingTroops)
	$Label.text = "You won wow. \nYour remaining troops: " + str(remainingTroops)
	pass # Replace with function body.
