extends "res://Scripts/Units/FriendlyUnit.gd"

func _ready():
	health = 60
	moveSpeed = 90
	updateElements()

var harvest =false
var harvestArea

var inventory = 0
var maxInventory = 10000
var itemType = null

func _physics_process(delta):
	if $AttackArea.get_overlapping_areas() != null && _arrived_at_location() == true:
		for area in $AttackArea.get_overlapping_areas():
			if area.is_in_group("WorkSpace"):
				harvest = true
				harvestArea = area
				if $WorkTimer.is_stopped() == true || $WorkTimer.is_paused()==true:
					$WorkTimer.wait_time = area.workTime
					$WorkTimer.start()
				if inventory < maxInventory && itemType == area.itemType && area.pickUp > 0 || inventory < maxInventory && itemType == null && area.pickUp > 0:
					if itemType == null:
						area.pickUp -= 1
						inventory += 1
						itemType = area.itemType
					else: 
						area.pickUp -= 1
						inventory += 1
	
	else:
		harvest = false
	
	if harvest == false:
		$WorkTimer.stop()

func _on_Timer_timeout():
	if $AttackArea.get_overlapping_areas() != null && _arrived_at_location() == true:
			for area in $AttackArea.get_overlapping_areas():
				if area.is_in_group("WorkSpace"):
					if area == harvestArea:
						area.Work()
						print("Work")
