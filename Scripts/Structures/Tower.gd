extends StaticBody2D

var friendly = false
var Damage = 20
var attackSpeed = 3
var buildingPlaced = true

func _ready():
	$Timer.wait_time = attackSpeed
	$Timer.one_shot = true
	$Timer.start()

func _physics_process(delta):
	shoot()
	buildingpreview()

func shoot():
	#Friendly version
	if $ShootingArea.get_overlapping_bodies().size() > 0 && $Timer.time_left <= 0 && buildingPlaced==true:
		for body in $ShootingArea.get_overlapping_bodies():
			if body.is_in_group("enemyUnit") && friendly == true:
				body.setHealth(body.health-Damage,body.blockChance)
				$Timer.start()
				return
		
		#Enemy version
		for body in $ShootingArea.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit") && friendly == false:
				body.setHealth(body.health-Damage,body.blockChance)
				$Timer.start()
				return

func buildingpreview():
	if buildingPlaced == false:
		$CollisionShape2D.set_disabled(true)
	else:
		$CollisionShape2D.set_disabled(false)
		pass
