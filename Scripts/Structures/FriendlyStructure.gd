extends "res://Scripts/Structures/Structure.gd"

func _ready():
	outlineColor = Color(0, 1, 1, 1)
	friendly = true
	updateElements()

func _physics_process(delta):
	if selected:
		$Sprite.material.set_shader_param("hide", false)
		$Sprite.material.set_shader_param("line_thickness", 6)
		# Fade in to show health bar
		$HealthBar.modulate.a = lerp($HealthBar.modulate.a, 1, healthBarFadeSpeed)

func _input(event):
	if event is InputEventMouseButton && event.get_button_index() == 1:
		selected = mouseOver
