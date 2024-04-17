extends KinematicBody2D

onready var navigation_agent = $NavigationAgent2D
# Movement
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var direction = Vector2.ZERO
var did_arrive = false

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

onready var death_effect = preload("res://Scenes/Effects/DeathEffect.tscn")
onready var bloodParticle = preload("res://Scenes/Particle/BloodParticle.tscn")

# Unit selection
var selected = false
var mouseOver = false

# Health bar
var healthBarFadeSpeed = 0.1
var healthBarProgressSpeed = 0.1

var rng = RandomNumberGenerator.new()
# rng block number
var blockNumber

func _ready():
	updateElements()

func Attack():
	if $AttackArea.get_overlapping_bodies().size()>0 && $AttackTimer.time_left <= 0:
		for body in $AttackArea.get_overlapping_bodies():
			if friendly == true:
				if body.is_in_group("enemyUnit"):
					body.setHealth(body.health - attackDamage, true)
					$AttackTimer.start()
					return
			elif friendly==false:
				if body.is_in_group("friendlyUnit"):
					body.setHealth(body.health - attackDamage, true)
					$AttackTimer.start()
					return

func _physics_process(delta):
	if is_instance_valid(navigation_agent):
		direction = position.direction_to(navigation_agent.get_next_location())
		velocity = direction * moveSpeed
		navigation_agent.set_velocity(velocity)
	
	# Slowly approach correct health value on health bar
	if $HealthBar.value != health:
		$HealthBar.value = lerp($HealthBar.value, health, healthBarProgressSpeed)
	
	# Health bar fade in if recently hit
	if $HealthBarTimer.time_left > 0 or mouseOver:
		$HealthBar.modulate.a = lerp($HealthBar.modulate.a, 1, healthBarFadeSpeed)
	# Healh bar fade out if not hit and not selected
	elif !selected:
		$HealthBar.modulate.a = lerp($HealthBar.modulate.a, 0, healthBarFadeSpeed)

func _arrived_at_location() -> bool:
	return navigation_agent.is_navigation_finished()

func set_target_location(target:Vector2):
	navigation_agent.set_target_location(target)

func _on_NavigationAgent2D_velocity_computed(safe_velocity):
	if not _arrived_at_location():
		velocity = move_and_slide(safe_velocity)
	elif not did_arrive:
		did_arrive = true
		emit_signal("path_changed", [])
		emit_signal("targed_reached")

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

func die():
	var deathEffectInst = death_effect.instance()
	deathEffectInst.unitSprite = $Sprite.texture
	deathEffectInst.unitSpriteWidth = $Sprite.scale.x
	deathEffectInst.unitSpriteHeight = $Sprite.scale.y
	var world = get_tree().current_scene
	world.add_child(deathEffectInst)
	deathEffectInst.global_position = global_position
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
	
	maxSpeed = moveSpeed

func setAudioRandomGrunt():
	rng.randomize()
	var gruntSoundNumber = rng.randi_range(1, 4)
	match gruntSoundNumber:
		1:
			$UnitAudio.stream = load("res://Assets/Sounds/Units/HurtSounds/male_grunt.mp3")
		2:
			$UnitAudio.stream = load("res://Assets/Sounds/Units/HurtSounds/male_grunt2.mp3")
		3:
			$UnitAudio.stream = load("res://Assets/Sounds/Units/HurtSounds/male_grunt3.mp3")
		4:
			$UnitAudio.stream = load("res://Assets/Sounds/Units/HurtSounds/male_grunt4.mp3")
	$UnitAudio.pitch_scale = 1

