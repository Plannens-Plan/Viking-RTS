extends "res://Scripts/Units/FriendlyUnit.gd"
func _ready():
	pass

var harvest =false

func _physics_process(delta):
	if $MouseOver.get_overlapping_areas() && targetPosition==null:
		for area in $MouseOver.get_overlapping_areas():
			if area.is_in_group("WorkSpace"):
				$Timer.wait_time=5
				area.Work()
