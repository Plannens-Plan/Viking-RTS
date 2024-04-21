extends KinematicBody2D

onready var navigation_agent = $NavigationAgent2D
onready var collision_timer = $CollisionTimer

# Movement
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var direction = Vector2.ZERO
var did_arrive = false
var target = Vector2.ZERO
var target_max = 1 
var last_distance_to_target = Vector2.ZERO
var current_distance_to_target = Vector2.ZERO
var move_threshold = 5

# Default unit stats
var moveSpeed = 100
var maxSpeed
var friction = 0.5
var health = 100
var maxHealth = 100
var attackDamage = 25
# Time between each attack in seconds
var attackSpeed = 1
var friendly = false
# Chance to block an attack in percent
var blockChance = 0
var newunit = true
var stop = false

onready var death_effect = preload("res://Scenes/Effects/DeathEffect.tscn")
onready var bloodParticle = preload("res://Scenes/Particle/BloodParticle.tscn")
onready var blockParticle = preload("res://Scenes/Particle/BlockingParticles.tscn")

# Unit selection
var selected = false
var mouseOver = false

# Health bar
var healthBarFadeSpeed = 0.1
var healthBarProgressSpeed = 0.1

var rng = RandomNumberGenerator.new()
# RNG block number
var blockNumber

# The sound a unit makes when attacking
var attackSound

# The signal a unit sends when it dies
signal dead_soldier

# The RGB color code for the unit's outline, default value is white
var outlineColor = Color(1, 1, 1, 1)

func _ready():
	target = position
	updateElements()

func attack():
	if $AttackArea.get_overlapping_bodies().size() > 0 && $AttackTimer.time_left <= 0:
		for body in $AttackArea.get_overlapping_bodies():
			if friendly == true:
				if body.is_in_group("enemyUnit") or body.is_in_group("neutralUnit"):
					body.setHealth(body.health - attackDamage, true)
					if attackSound != null:
						setAttackSound()
						$UnitAudio.play()
					$AttackTimer.start()
					return
			elif friendly == false:
				if body.is_in_group("friendlyUnit"):
					body.setHealth(body.health - attackDamage, true)
					if attackSound != null:
						setAttackSound()
						$UnitAudio.play()
					$AttackTimer.start()
					return
	if $AttackArea.get_overlapping_areas().size() > 0 && $AttackTimer.time_left <= 0 && !$AttackArea.get_overlapping_bodies().size() < 0:
		for area in $AttackArea.get_overlapping_areas():
			if friendly == true:
				if area.is_in_group("enemyBuilding"):
					area.setHealth(area.health - attackDamage)
					if attackSound != null:
						setAttackSound()
						$UnitAudio.play()
					$AttackTimer.start()
					return

func _physics_process(delta):
	if !stop:
		if target.x < position.x:
			$Sprite.flip_h = true
		else:
			$Sprite.flip_h = false
		velocity = Vector2.ZERO
		if position.distance_to(target) > target_max:
			velocity = position.direction_to(target) * moveSpeed
			velocity = move_and_slide(velocity)
		if position.distance_to(target) < 60: 
			if get_slide_count() > 0 and collision_timer.is_stopped():
				collision_timer.start()
				last_distance_to_target = position.distance_to(target)

	if mouseOver and !selected:
		$Sprite.material.set_shader_param("hide", false)
		$Sprite.material.set_shader_param("line_thickness", 3)
	if !mouseOver and !selected:
		$Sprite.material.set_shader_param("hide", true)
	updateHealthBar()

func _on_CollisionTimer_timeout():
	if get_slide_count():
		current_distance_to_target = position.distance_to(target)
		if last_distance_to_target < current_distance_to_target + move_threshold:
			target = position

func set_target_location(targetInput:Vector2):
	target = targetInput

func arrived_at_location() -> bool:
	if target == position:
		return true
	else:
		return false

func setHealth(newHealth, canBeBlocked):
	if canBeBlocked:
		rng.randomize()
		blockNumber = rng.randi_range(0, 100)
		if blockNumber <= blockChance:
			setAudioRandomBlock()
			var blockParticleInstance = blockParticle.instance()
			blockParticleInstance.get_node("BlockingExplosion").emitting = true
			blockParticleInstance.emitting = true
			add_child(blockParticleInstance)
			$UnitAudio.play()
			return
	if health > newHealth:
		setAudioRandomGrunt()
		$UnitVoice.play()
		resetAudio("UnitAudio")
		$UnitAudio.stream = load("res://Assets/Sounds/Units/flesh_impact.mp3")
		$UnitAudio.pitch_scale = rng.randf_range(0.8,1.2)
		$UnitAudio.volume_db = -10
		$UnitAudio.play()
		var bloodParticleInstance = bloodParticle.instance()
		bloodParticleInstance.emitting = true
		add_child(bloodParticleInstance)
	health = newHealth
	$HealthBarTimer.start()
	if health <= 0:
		die()

func die():
	var deathEffectInst = death_effect.instance()
	deathEffectInst.unitSprite = $Sprite.texture
	deathEffectInst.unitSpriteWidth = $Sprite.scale.x
	deathEffectInst.unitSpriteHeight = $Sprite.scale.y
	deathEffectInst.unit = true
	var world = get_tree().current_scene
	world.get_node("DeathEffects").add_child(deathEffectInst)
	deathEffectInst.global_position = global_position
	emit_signal("dead_soldier")
	queue_free()

func _on_MouseOver_mouse_entered():
	mouseOver = true

func _on_MouseOver_mouse_exited():
	mouseOver = false

# Call this when you change unit stats
func updateElements():
	$HealthBar.max_value = maxHealth
	$HealthBar.value = health
	$HealthBar.modulate.a = 0
	
	if not ($AttackTimer == null):
		$AttackTimer.wait_time = attackSpeed
		$AttackTimer.one_shot = true
		$AttackTimer.start()
	$Sprite.material.set_shader_param("line_color", outlineColor)
	maxSpeed = moveSpeed

func setAudioRandomGrunt():
	rng.randomize()
	var gruntSoundNumber = rng.randi_range(1, 4)
	match gruntSoundNumber:
		1:
			$UnitVoice.stream = load("res://Assets/Sounds/Units/HurtSounds/male_grunt.mp3")
		2:
			$UnitVoice.stream = load("res://Assets/Sounds/Units/HurtSounds/male_grunt2.mp3")
		3:
			$UnitVoice.stream = load("res://Assets/Sounds/Units/HurtSounds/male_grunt3.mp3")
		4:
			$UnitVoice.stream = load("res://Assets/Sounds/Units/HurtSounds/male_grunt4.mp3")
	resetAudio("UnitVoice")
	$UnitVoice.volume_db = -10
	$UnitVoice.pitch_scale = rng.randf_range(0.9,1.1)

func setAudioRandomBlock():
	rng.randomize()
	var blockSoundNumber = rng.randi_range(1, 3)
	match blockSoundNumber:
		1:
			$UnitAudio.stream = load("res://Assets/Sounds/Units/block.mp3")
		2:
			$UnitAudio.stream = load("res://Assets/Sounds/Units/block2.mp3")
		3:
			$UnitAudio.stream = load("res://Assets/Sounds/Units/block3.mp3")
	resetAudio("UnitAudio")
	$UnitAudio.pitch_scale = rng.randf_range(0.7,1.3)

func setAttackSound():
	resetAudio("UnitAudio")
	$UnitAudio.stream = attackSound
	$UnitAudio.pitch_scale = rng.randf_range(0.8,1.2)
	$UnitAudio.volume_db = -10

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

func resetAudio(var audioPlayer):
	match audioPlayer:
		"UnitAudio":
			$UnitAudio.volume_db = 0
			$UnitAudio.pitch_scale = 1
		"UnitVoice":
			$UnitVoice.volume_db = 0
			$UnitVoice.pitch_scale = 1
		"UnitVoiceLines":
			$UnitVoiceLines.volume_db = 0
			$UnitVoiceLines.pitch_scale = 1

