extends Area2D

onready var death_effect = preload("res://Scenes/Effects/DeathEffect.tscn")
onready var fireParticle = preload("res://Scenes/Particle/FireParticles.tscn")

var mouseOver = false
var selected = false

var healthBarFadeSpeed = 0.1
var healthBarProgressSpeed = 0.1

var health = 500
var maxHealth = 500

var friendly

# The RGB color code for the unit's outline, default value is white
var outlineColor = Color(1, 1, 1, 1)

var rng = RandomNumberGenerator.new()

func _ready():
	updateElements()

signal dead_building

func _physics_process(delta):
	if mouseOver and !selected:
		$Sprite.material.set_shader_param("hide", false)
		$Sprite.material.set_shader_param("line_thickness", 3)
	if !mouseOver and !selected:
		$Sprite.material.set_shader_param("hide", true)
	updateHealthBar()

#mangler breaking effekt
func setHealth(newHealth):
	if health > newHealth:
		if !$StructureAudio.playing:
			resetAudio()
			$StructureAudio.stream = load("res://Assets/Sounds/Structures/fire_puff.mp3")
			$StructureAudio.pitch_scale = rng.randf_range(0.8,1.2)
			$StructureAudio.play()
		var fireParticleInstance = fireParticle.instance()
		fireParticleInstance.emitting = true
		add_child(fireParticleInstance)
	health = newHealth
	$HealthBarTimer.start()
	if health <= 0:
		die()

func die():
	var deathEffectInst = death_effect.instance()
	deathEffectInst.spritePosX = $Sprite.position.x
	deathEffectInst.spritePosY = $Sprite.position.y
	deathEffectInst.unitSprite = $Sprite.texture
	deathEffectInst.unitSpriteWidth = $Sprite.scale.x
	deathEffectInst.unitSpriteHeight = $Sprite.scale.y
	deathEffectInst.unit = false
	var world = get_tree().current_scene
	world.get_node("Objects/DeathEffects").add_child(deathEffectInst)
	deathEffectInst.global_position = global_position
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
	$Sprite.material.set_shader_param("line_color", outlineColor)

func updateHealthBar():
	# Slowly approach correct health value on health bar
	if $HealthBar.value != health:
		$HealthBar.value = lerp($HealthBar.value, health, healthBarProgressSpeed)
	
	# Health bar fade in if recently hit or mouse over
	if $HealthBarTimer.time_left > 0 or mouseOver:
		$HealthBar.modulate.a = lerp($HealthBar.modulate.a, 1, healthBarFadeSpeed)
	# Healh bar fade out
	elif !selected:
		$HealthBar.modulate.a = lerp($HealthBar.modulate.a, 0, healthBarFadeSpeed)

func resetAudio():
	$StructureAudio.volume_db = 0
	$StructureAudio.pitch_scale = 1
