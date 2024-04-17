extends Node2D

var unitSprite
var unitSpriteWidth
var unitSpriteHeight
var rng = RandomNumberGenerator.new()
var deathSoundNumber

func _ready():
	$Sprite.texture = unitSprite
	$Sprite.scale.x = unitSpriteWidth
	$Sprite.scale.y = unitSpriteHeight
	rng.randomize()
	deathSoundNumber = rng.randi_range(1, 4)
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

func _physics_process(delta):
	if rotation_degrees < 90:
		rotate(0.05)
	$Sprite.modulate.a -= 0.005
	if !$DeathScream.playing and !$DeathSound.playing and rotation_degrees >= 90 and $Sprite.modulate.a <= 0:
		queue_free()
