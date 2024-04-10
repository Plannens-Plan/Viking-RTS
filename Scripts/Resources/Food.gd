extends Node2D

onready var GlobalVariable= get_node("/root/GlobalVariables")


func _on_Click_pressed():
	var rngwood=RandomNumberGenerator.new()
	GlobalVariable.VikingRts.resources.food+=rngwood.randi_range(12,18)
	print(GlobalVariable.VikingRts.resources.food)
	pass # Replace with function body.
