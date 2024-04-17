extends Node2D

var health = 100
var maxHealth = 100

# Health bar
var healthBarFadeSpeed = 0.1
var healthBarProgressSpeed = 0.1

var selected = false
var mouseOver = false

func _physics_process(delta):
	updateHealthBar()

func updateHealthBar():
	# Slowly approach correct health value on health bar
	if $HealthBar.value != health:
		$HealthBar.value = lerp($HealthBar.value, health, healthBarProgressSpeed)
	
	# Health bar fade in if recently hit or mouse over
	if $HealthBarTimer.time_left > 0 or mouseOver:
		$HealthBar.modulate.a = lerp($HealthBar.modulate.a, 1, healthBarFadeSpeed)
	# Healh bar fade out if not hit and not selected
	elif !selected:
		$HealthBar.modulate.a = lerp($HealthBar.modulate.a, 0, healthBarFadeSpeed)
		
		
func die():
	var deathEffectInst = death_effect.instance()
	deathEffectInst.unitSprite = $Sprite.texture
	deathEffectInst.unitSpriteWidth = $Sprite.scale.x
	deathEffectInst.unitSpriteHeight = $Sprite.scale.y
	var world = get_tree().current_scene
	world.add_child(deathEffectInst)
	deathEffectInst.global_position = global_position
	queue_free()
	
func setHealth(newHealth, canBeBlocked):
	if canBeBlocked:
		rng.randomize()
		blockNumber = rng.randi_range(0, 100)
		if blockNumber <= blockChance:
			$UnitAudio.stream = load("res://Assets/Sounds/Units/block.mp3")
			$UnitAudio.pitch_scale = rng.randf_range(0.7,1.3)
			$UnitAudio.play()
			return
	if health > newHealth:
		setAudioRandomGrunt()
		$UnitAudio.play()
		var bloodParticleInstance = bloodParticle.instance()
		bloodParticleInstance.emitting = true
		add_child(bloodParticleInstance)
	health = newHealth
	$HealthBarTimer.start()
	if health <= 0:
		die()
