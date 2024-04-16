extends "res://Scripts/Units/Unit.gd"

func _ready():
	friendly=true
	set_target_location(position)

func _physics_process(delta):
	Attack()
	if !selected:
		$Sprite.material = null
	else:
		# Give outline
		$Sprite.material = load("res://Assets/Materials/Outline.tres")
		# Fade in to show health bar
		$HealthBar.modulate.a = lerp($HealthBar.modulate.a, 1, healthBarFadeSpeed)


func _input(event):
	if event is InputEventMouseButton && event.get_button_index() == 1:
		selected = mouseOver

	if event is InputEventMouseButton && event.get_button_index() == 2 && selected:
		set_target_location(get_global_mouse_position())


func _on_NavigationAgent2D_target_reached():
	pass # Replace with function body.
func sethealth():
	pass

