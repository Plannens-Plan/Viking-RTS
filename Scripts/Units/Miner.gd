extends "res://Scripts/Units/FriendlyUnit.gd"

func _ready():
	finalUnit = true
	if newunit:
		health = 50
		maxHealth = 50
		moveSpeed = 90
		attackDamage = 15
		attackSpeed = 0.8
		blockChance = 0
		attackSound = load("res://Assets/Sounds/Units/whoosh_light.mp3")
	updateElements()

var harvest = false
var harvestArea

var inventory = 0
var maxInventory = 1000
var itemType = null
var inventoryDic = {
	"stone" : 0,
	"wood" : 0,
	"food" : 0,
	"silver" : 0,
	}

func _physics_process(delta):
	if inventory < maxInventory:
		$Encumbered.hide()
	if $AttackArea.get_overlapping_areas() != null:
		for area in $AttackArea.get_overlapping_areas():
			if area.is_in_group("WorkSpace"):
				harvest = true
				harvestArea = area
				if $WorkTimer.is_stopped() == true || $WorkTimer.is_paused()==true:
					$WorkTimer.wait_time = area.workTime
					$WorkTimer.start()
				if inventory <= maxInventory:
					area.pickUp -= 1
					inventoryDic[area.itemType] += 1
					inventory += 1
				else:
					$Encumbered.show()
	else:
		harvest = false
	
	if harvest == false:
		$WorkTimer.stop()
	
	if inventory <= 0:
		itemType = null

func _on_Timer_timeout():
	if $AttackArea.get_overlapping_areas() != null:
			for area in $AttackArea.get_overlapping_areas():
				if area.is_in_group("WorkSpace"):
					if area == harvestArea:
						area.Work()
