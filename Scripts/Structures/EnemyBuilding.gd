extends Area2D

var mouseOver = false


var healthBarFadeSpeed = 0.1
var healthBarProgressSpeed = 0.1

var health = 100
var maxHealth = 100

var friendly = false

func _ready():
	updateElements()
	

signal dead_building

func _process(delta):
	updateHealthBar()

func setHealth(newHealth):
	#if health > newHealth:
		#var bloodParticleInstance = bloodParticle.instance()
		#bloodParticleInstance.emitting = true
		#add_child(bloodParticleInstance)
	health = newHealth
	$HealthBarTimer.start()
	if health <= 0:
		die()

func die():
	#var deathEffectInst = death_effect.instance()
	#deathEffectInst.unitSprite = $Sprite.texture
	#deathEffectInst.unitSpriteWidth = $Sprite.scale.x
	#deathEffectInst.unitSpriteHeight = $Sprite.scale.y
	#var world = get_tree().current_scene
	#world.add_child(deathEffectInst)
	#deathEffectInst.global_position = global_position
	emit_signal("dead_building")
	queue_free()

func _on_MouseOver_mouse_entered():
	mouseOver = true

func _on_MouseOver_mouse_exited():
	mouseOver = false


func updateElements():
	$HealthBar.max_value = maxHealth
	$HealthBar.value = health
	$HealthBar.modulate.a = 0
	
	#$Sprite.material.set_shader_param("line_color", outlineColor)

func updateHealthBar():
	# Slowly approach correct health value on health bar
	if $HealthBar.value != health:
		$HealthBar.value = lerp($HealthBar.value, health, healthBarProgressSpeed)
	
	# Health bar fade in if recently hit or mouse over
	if $HealthBarTimer.time_left > 0 or mouseOver:
		$HealthBar.modulate.a = lerp($HealthBar.modulate.a, 1, healthBarFadeSpeed)
