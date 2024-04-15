extends "res://Scripts/Units/Unit.gd"

onready var attackArea = $AttackArea
onready var attackTimer = $AttackTimer

func _ready():
	attackTimer.wait_time = attackSpeed
	attackTimer.one_shot=true
	attackTimer.start()
	pass

func Attack():
	if attackArea.get_overlapping_bodies().size()>0 && attackTimer.time_left <= 0:
		for body in attackArea.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit"):
				body.setHealth(body.health - attackDamage)
				attackTimer.start()
				return

func TargetingFriendly():
	
	pass

func _physics_process(delta):
	Attack()
	pass
