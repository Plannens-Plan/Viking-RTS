extends Node2D

onready var GlobalVariable= get_node("/root/GlobalVariables")


func _on_Click_pressed():
	var rngwood=RandomNumberGenerator.new()
	GlobalVariable.VikingRts.resources.wood+=rngwood.randi_range(8,15)
	print(GlobalVariable.VikingRts.resources.wood)
	pass # Replace with function body.
