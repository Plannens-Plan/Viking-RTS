extends "res://Scripts/Units/FriendlyUnit.gd"
func _ready():
	pass

var harvest =false
var harvestArea

func _physics_process(delta):
	if $MouseOver.get_overlapping_areas() && targetPosition == null:
		for area in $MouseOver.get_overlapping_areas():
			if area.is_in_group("WorkSpace"):
				harvest=true
				harvestArea=area
				if $Timer.is_stopped()==true||$Timer.is_paused()==true:
					print("bruh")
					$Timer.wait_time = area.workTime
					$Timer.start()
					$Timer.paused=false
				
			
		
		if harvest==false:
			print("bruhballs")
			$Timer.paused=true
			$Timer.stop()
		print("braaauh")
		harvest=false


func _on_Timer_timeout():
	print("balls")
	if $MouseOver.get_overlapping_areas() && targetPosition==null:
			for area in $MouseOver.get_overlapping_areas():
				if area.is_in_group("WorkSpace"):
					if area==harvestArea:
						area.Work()
