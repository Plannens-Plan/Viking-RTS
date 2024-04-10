extends Area2D



onready var GlobalVariable= get_node("/root/GlobalVariables")


func _on_PurchaseTroop_pressed():
	var res=GlobalVariable.VikingRts.resources
	if res.food >= 15 and res.wood >= 8:
		res.food-=15
		res.wood-=8
		var troop = load("res://Scenes/Units/FriendlyUnit.tscn").instance()
		troop.position = position
		var scene=get_tree().get_root().get_child(0)
		if scene.name=="GlobalVariables":
			scene=get_tree().get_root().get_child(1)
		scene.get_node("FriendlyUnits").add_child(troop)
	
	pass # Replace with function body.
