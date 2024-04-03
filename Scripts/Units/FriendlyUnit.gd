extends "res://Scripts/Units/Unit.gd"
var selected = false
var mouseOver = false
var targetLocationX = 0.0
var targetLocationY = 0.0
var target = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	targetLocation()

func _on_Area2D_mouse_entered():
	mouseOver=true


func _on_Area2D_mouse_exited():
	mouseOver=false

func _input(event):
	if event is InputEventMouseButton && event.get_button_index()==1 && mouseOver==true:
		selected=true
		
	if event is InputEventMouseButton && event.get_button_index()==1 && mouseOver==false:
		selected=false
	if event is InputEventMouseButton && event.get_button_index()==2 && selected==true:
		targetLocationX=get_global_mouse_position().x as float
		targetLocationY=get_global_mouse_position().y as float
		target=true


func targetLocation():
	if target==true:
		print (target)
		if position.x!=targetLocationX:
			if position.x > targetLocationX:
				position.x=position.x-moveSpeed
				if position.x < targetLocationX:
					position.x=targetLocationX
					target==false
					return
			if position.x<targetLocationX:
				position.x=position.x+moveSpeed
				if position.x>targetLocationX:
					position.x=targetLocationX
					target==false
					return
