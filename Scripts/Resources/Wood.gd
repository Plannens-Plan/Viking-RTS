extends Node2D

onready var GlobalVariable= get_node("/root/GlobalVariables")
#GlobalVariable.VikinRts.xxx = yyy eller GlobalVariable.VikinRts["xxx"] = yyy
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Click_pressed():
	var rngwood=RandomNumberGenerator.new()
	GlobalVariable.VikingRts.resources.wood+=rngwood.randi_range(8,15)
	print(GlobalVariable.VikingRts.resources.wood)
	pass # Replace with function body.
