extends Node2D

var unitSprite
var unitSpriteWidth
var unitSpriteHeight
var rng = RandomNumberGenerator.new()
var deathSoundNumber
var unit = false

func _ready():
	$Sprite.texture = unitSprite
	$Sprite.scale.x = unitSpriteWidth
	$Sprite.scale.y = unitSpriteHeight
	rng.randomize()
	deathSoundNumber = rng.randi_range(1, 4)
	if unit:
		match deathSoundNumber:
			1:
				$DeathScream.stream = load("res://Assets/Sounds/Units/DeathSounds/death_scream.mp3")
				$DeathScream.volume_db = 0
			2:
				$DeathScream.stream = load("res://Assets/Sounds/Units/DeathSounds/male_scream.mp3")
				$DeathScream.volume_db = -10
			3:
				$DeathScream.stream = load("res://Assets/Sounds/Units/DeathSounds/male_scream2.mp3")
				$DeathScream.volume_db = -5
			4:
				$DeathScream.stream = load("res://Assets/Sounds/Units/DeathSounds/male_death.mp3")
				$DeathScream.volume_db = 0
		$DeathScream.play()
		$DeathSound.pitch_scale = rng.randf_range(0.7,1.3)
		$DeathSound.play()
	else:
		$DeathSound.pitch_scale = rng.randf_range(0.8,1.2)
		$DeathSound.stream = load("res://Assets/Sounds/Structures/intense_fire.mp3")
		$DeathSound.play()

func _physics_process(delta):
	$Sprite.modulate.a -= 0.005
	if rotation_degrees < 90 and unit:
		rotate(0.05)
	if !unit:
		$DeathSound.volume_db -= 0.1
	if !$DeathScream.playing and !$DeathSound.playing and $Sprite.modulate.a <= 0:
		if !unit and $DeathSound.volume_db <= -60:
			queue_free()
		if unit and rotation_degrees >= 90:
			queue_free()
