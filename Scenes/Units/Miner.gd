extends "res://Scripts/Units/FriendlyUnit.gd"
func _ready():
	pass

func _physics_process(delta):
	if $MouseOver.get_overlapping_bodies():
		for body in $MouseOver.get_overlapping_bodies():
			if body.is_in_group("WorkSpace"):
				body.Work()
			else:
				print ("no workspace")
				print ($MouseOver.get_overlapping_bodies())
