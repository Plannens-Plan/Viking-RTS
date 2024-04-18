extends Control


onready var GlobalVariable= get_node("/root/GlobalVariables")
onready var remainingTroops = GlobalVariable.RemainingTroops


func _ready():
	print (remainingTroops)
	
	
	if remainingTroops > 1:
		$Label.text = "You won wow. \nYour remaining troops: " + str(remainingTroops-1)
	else:
		$Label.text = "You lost wow. \nYour remaining troops is now GGS: " + str(remainingTroops-1)
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Map/Grandmap.tscn")
	pass # Replace with function body.
