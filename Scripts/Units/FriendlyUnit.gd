extends "res://Scripts/Units/Unit.gd"
var selected = false
var mouseOver = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Area2D_mouse_entered():
	mouseOver=true


func _on_Area2D_mouse_exited():
	mouseOver=false

func _input(event):
	if event is InputEventMouseButton && event.get_button_index()==1 && mouseOver==true:
		selected=true
		
	if event is InputEventMouseButton && event.get_button_index()==1 && mouseOver==false:
		selected=false
