extends Node2D

onready var GlobalVariable= get_node("/root/GlobalVariables")


func _on_Click_pressed():
	var rngwood=RandomNumberGenerator.new()
	GlobalVariable.VikingRts.resources.stone+=rngwood.randi_range(3,8)
	print(GlobalVariable.VikingRts.resources.stone)
	pass # Replace with function body.
