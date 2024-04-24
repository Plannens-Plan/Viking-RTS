extends "res://Scripts/Structures/FriendlyStructure.gd"

var itemType = null

func _ready():
	health = 500
	maxHealth = 500
	updateElements()

func _physics_process(delta):
	deposit()

func deposit():
	if get_overlapping_bodies().size() > 0:
		for body in get_overlapping_bodies():
			if body.is_in_group("harvester") && body.inventory > 0:
				depositItemType(body,"wood")
				depositItemType(body,"silver")
				depositItemType(body,"food")
				depositItemType(body,"stone")

func depositItemType(var body, var itemType):
	if body.inventoryDic[itemType]> 0:
		GlobalVariables.VikingRts.resources[itemType] += 2
		body.inventoryDic[itemType] -= 2
		body.inventory -= 2
	pass
