extends Control

var remainingTroops

func _ready():
	print (remainingTroops)
	$Label.text = "You won wow. \n Your remaining troops: " + str(remainingTroops)
	pass # Replace with function body.
