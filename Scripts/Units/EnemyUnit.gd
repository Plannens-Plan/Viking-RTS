extends "res://Scripts/Units/Unit.gd"

func _ready():
	$AttackTimer.wait_time = attackSpeed
	$AttackTimer.one_shot=true
	$AttackTimer.start()
	pass

func Attack():
	if $AttackArea.get_overlapping_bodies().size()>0 && $AttackTimer.time_left <= 0:
		for body in $AttackArea.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit"):
				body.setHealth(body.health - attackDamage)
				$AttackTimer.start()
				return

func TargetingFriendly():
	
	pass

func _physics_process(delta):
	Attack()
	pass
