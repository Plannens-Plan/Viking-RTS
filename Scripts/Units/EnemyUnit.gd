extends "res://Scripts/Units/Unit.gd"

var closestDistance = 2500
var closestUnit = null

func _ready():
	outlineColor = Color(1, 0, 0, 1)
	updateElements()

func _physics_process(delta):
	TargetFriendly()
	attack()

func TargetFriendly():
	for body in $DetectArea.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit"):
				var distance = position.distance_to(body.position)
				if distance < closestDistance:
					closestDistance = distance
					closestUnit = body

	if not closestUnit == null:
		if is_instance_valid(closestUnit):
			set_target_location(closestUnit.position)
		else:
			closestDistance = 2500
