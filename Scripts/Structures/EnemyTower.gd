extends "res://Scripts/Structures/enemyStructure.gd"

var damage = 25
var attackSpeed = 3
# Controls how many units can get attacked per arrow wave
var amountOfArchers = 2

func _ready():
	rng.randomize()
	health = 300
	maxHealth = 300
	updateElements()
	$Timer.wait_time = attackSpeed
	$Timer.one_shot = true
	$Timer.start()
	$ShootingArea/Sprite.scale.x = $ShootingArea/CollisionShape2D.scale.x * $ShootingArea/Sprite.scale.x
	$ShootingArea/Sprite.scale.y = $ShootingArea/CollisionShape2D.scale.y * $ShootingArea/Sprite.scale.y

func _physics_process(delta):
	if mouseOver:
		$ShootingArea/Sprite.visible = true
	else:
		$ShootingArea/Sprite.visible = false
	shoot()

func shoot():
	if $ShootingArea.get_overlapping_bodies().size() > 0 && $Timer.time_left <= 0:
		var peopleShot = 0
		for body in $ShootingArea.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit") && friendly == false:
				body.setHealth(body.health - damage, true)
				$Timer.start()
				if !$StructureAudio.playing:
					resetAudio()
					$StructureAudio.stream = load("res://Assets/Sounds/Units/quick_whoosh.mp3")
					$StructureAudio.pitch_scale = rng.randf_range(0.6, 1.4)
					$StructureAudio.play()
				peopleShot += 1
				if peopleShot >= amountOfArchers:
					peopleShot = 0
					return
