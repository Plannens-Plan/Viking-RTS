extends "res://Scripts/Units/Unit.gd"

func _ready():
	friendly = true
	set_target_location(position)
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
		selected = mouseOver

	if event is InputEventMouseButton && event.get_button_index() == 2 && selected:
		set_target_location(get_global_mouse_position())

func _on_NavigationAgent2D_target_reached():
	pass 

func sethealth():
	pass

func updateElements():
	$HealthBar.max_value = maxHealth
	$HealthBar.value = health
	$HealthBar.modulate.a = 0
	
	$AttackTimer.wait_time = attackSpeed
	$AttackTimer.one_shot = true
	$AttackTimer.start()
