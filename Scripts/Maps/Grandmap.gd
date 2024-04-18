extends Node2D

onready var GlobalVariable= get_node("/root/GlobalVariables")
onready var progression=GlobalVariable.VikingRts.progression
func _ready():
	GlobalVariable.Friendly=false
	if progression.beach:
		$Control/Engvik.disabled=false
	if progression.engvik:
		$Control/Buns.disabled=false



func _on_Beach_pressed():
	if progression.beach:
		GlobalVariable.Friendly=true
	get_tree().change_scene("res://Scenes/Map/Beach1.tscn")
	pass # Replace with function body.



func _on_Engvik_pressed():
	get_tree().change_scene("res://Scenes/Map/Engvik.tscn")
	pass # Replace with function body.
