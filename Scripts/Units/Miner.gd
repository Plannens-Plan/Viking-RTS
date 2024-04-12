extends "res://Scripts/Units/FriendlyUnit.gd"
func _ready():
	pass

func _physics_process(delta):
	if $MouseOver.get_overlapping_areas():
		for area in $MouseOver.get_overlapping_areas():
			if area.is_in_group("WorkSpace"):
				area.Work()
			else:
				pass
