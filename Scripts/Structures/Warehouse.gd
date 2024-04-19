extends "res://Scripts/Structures/FriendlyStructure.gd"

var itemType = null

func _ready():
	pass

func _physics_process(delta):
	deposit()

func deposit():
	if get_overlapping_bodies().size() > 0:
		for body in get_overlapping_bodies():
			if body.is_in_group("harvester") && body.inventory > 0:
				itemType = body.itemType
				match itemType:
					"Wood":
						GlobalVariables.VikingRts.resources.wood += 1
					"Food":
						GlobalVariables.VikingRts.resources.food += 1
					"Stone":
						GlobalVariables.VikingRts.resources.stone += 1
					"Silver":
						GlobalVariables.VikingRts.resources.silver += 1
				body.inventory-=1