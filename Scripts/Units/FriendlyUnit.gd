extends "res://Scripts/Units/Unit.gd"

var shiftHeld = false

func _ready():
	friendly = true
	outlineColor = Color(0, 1, 1, 1)
	updateElements()

func _physics_process(delta):
	attack()
	if selected:
		$Sprite.material.set_shader_param("hide", false)
		$Sprite.material.set_shader_param("line_thickness", 6)
		# Fade in to show health bar
		$HealthBar.modulate.a = lerp($HealthBar.modulate.a, 1, healthBarFadeSpeed)

func _input(event):
	if event is InputEventMouseButton && event.get_button_index() == 1:
		if selected == true && shiftHeld == true:
			selected = true
		else:
			selected = mouseOver

	if event is InputEventMouseButton && event.get_button_index() == 2 && selected:
		set_target_location(get_global_mouse_position())
	
	if event.is_action_pressed("shift"):
		shiftHeld = true
	if event.is_action_released("shift"):
		shiftHeld = false

func _on_NavigationAgent2D_target_reached():
	pass 

func sethealth():
	pass
