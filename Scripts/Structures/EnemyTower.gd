extends "res://Scripts/Structures/EnemyStructure.gd"

var damage = 25
var attackSpeed = 3
# Controls how many units can get attacked per arrow wave
var amountOfArchers = 2

func _ready():
	health = 300
	maxHealth = 300
	updateElements()
	$Timer.wait_time = attackSpeed
	$Timer.one_shot = true
	$Timer.start()

func _physics_process(delta):
	shoot()

func shoot():
	if $ShootingArea.get_overlapping_bodies().size() > 0 && $Timer.time_left <= 0:
		var peopleShot = 0
		for body in $ShootingArea.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit") && friendly == false:
				body.setHealth(body.health - damage, true)
				$Timer.start()
				peopleShot += 1
				if peopleShot >= amountOfArchers:
					peopleShot = 0
					return
