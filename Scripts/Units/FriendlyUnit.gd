extends "res://Scripts/Units/Unit.gd"

var selected = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("right_click"):
		if(get_global_mouse_position().x > position.x):
			acceleration.x += moveSpeed
		if(get_global_mouse_position().x < position.x):
			acceleration.x -= moveSpeed
