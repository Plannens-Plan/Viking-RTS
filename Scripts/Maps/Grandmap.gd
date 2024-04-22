extends Node2D

onready var GlobalVariable= get_node("/root/GlobalVariables")
onready var progression=GlobalVariable.VikingRts.progression

func _ready():
	GlobalVariable.Friendly=false
	GlobalVariable.Exiting=false
	if progression.beach:
		$Control/Engvik.disabled=false
		$Control/Clouds.hide()
	if progression.engvik:
		$Control/Buns.disabled=false
		$Control/Clouds2.hide()

func _on_Beach_pressed():
	$Control/Beach.disabled=true
	if progression.beach:
		GlobalVariable.Friendly=true
	TransitionScreen.change_scene("res://Scenes/Map/Beach1.tscn")

func _on_Engvik_pressed():
	$Control/Engvik.disabled=true
	if progression.engvik:
		GlobalVariable.Friendly=true
	TransitionScreen.change_scene("res://Scenes/Map/Beach2.tscn")

func _on_Buns_pressed():
	get_tree().quit()
