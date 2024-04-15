extends "res://Scripts/Units/Unit.gd"
# Unit selection

var selected = false
var mouseOver = false

func _ready():
	set_target_location(position)

func _physics_process(delta):
	if !selected:
		$Sprite.material = null
	else:
		# Give outline
		$Sprite.material = load("res://Assets/Materials/Outline.tres")
	
func _on_Area2D_mouse_entered():
	mouseOver = true

func _on_Area2D_mouse_exited():
	mouseOver = false

func _input(event):
	if event is InputEventMouseButton && event.get_button_index() == 1:
		selected = mouseOver

	if event is InputEventMouseButton && event.get_button_index() == 2 && selected:
		set_target_location(get_global_mouse_position())


func _on_NavigationAgent2D_target_reached():
	pass # Replace with function body.
