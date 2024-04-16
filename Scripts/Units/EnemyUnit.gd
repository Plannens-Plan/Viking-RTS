extends "res://Scripts/Units/Unit.gd"

var closestDistance = 1000
var closestUnit = null

func _physics_process(delta):
	print(closestDistance)
	print(closestUnit)
	
	TargetFriendly()
	Attack()

func TargetFriendly():
	for body in $DetectArea.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit"):
				var distance = position.distance_to(body.position)
				print(distance)
				if distance < closestDistance:
					closestDistance = distance
					closestUnit = body

func _physics_process(delta):
	Attack()
	if not closestUnit == null:
		if is_instance_valid(closestUnit):
			set_target_location(closestUnit.position)
		else:
			closestDistance = 1000
