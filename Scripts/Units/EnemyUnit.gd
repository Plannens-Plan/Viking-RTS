extends "res://Scripts/Units/Unit.gd"

var closestDistance = 0
var closestUnit = null

func TargettingFriendly():
	for body in $DetectArea.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit"):
				var distance = position.distance_to(body.position)
				if distance < closestDistance:
					closestDistance = distance
					closestUnit = body
					set_target_location(closestUnit.position)

func _physics_process(delta):
	Attack()
