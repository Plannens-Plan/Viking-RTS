extends Area2D

#var overlap = get_node("CollisionShape2D")
var unitsInside = false
var buildingPlaced = false

onready var GlobalVariable = get_node("/root/GlobalVariables")

func _on_PurchaseTroop_pressed():
	if buildingPlaced == true:
		$Panel.visible = !$Panel.visible
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("unit"):
		unitsInside = true
	print(unitsInside)

func _on_Area2D_body_exited(body):
	if body.is_in_group("unit"):
		unitsInside = false
	print(unitsInside)

func _on_Timer_timeout():
	$CanvasLayer/NoRoomMessage.hide()
	# Do something when the timer times out


func _on_PurchaseSword_pressed():
	var timer
	timer = Timer.new()
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	var res=GlobalVariable.VikingRts.resources
	if res.food >= 15 and res.wood >= 8:
		if unitsInside == false:
			var troop = load("res://Scenes/Units/FriendlyUnit.tscn").instance()
			res.food-=15
			res.wood-=8
			troop.position = position
			var scene=get_tree().get_root().get_child(0)
			if scene.name=="GlobalVariables":
				scene=get_tree().get_root().get_child(1)
			scene.get_node("FriendlyUnits").add_child(troop)
			print("yes")
		else:
			timer.wait_time = 2
			add_child(timer)
			timer.start()
			$CanvasLayer/NoRoomMessage.show()
			print("bruh")
	pass # Replace with function body.


func _on_PurchaseMiner_pressed():
	var timer
	timer = Timer.new()
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	var res=GlobalVariable.VikingRts.resources
	if res.food >= 20 and res.wood >= 20:
		if unitsInside == false:
			var troop = load("res://Scenes/Units/Miner.tscn").instance()
			res.food-=15
			res.wood-=8
			troop.position = position
			var scene=get_tree().get_root().get_child(0)
			if scene.name=="GlobalVariables":
				scene=get_tree().get_root().get_child(1)
			scene.get_node("friendlyUnit").add_child(troop)
			print("yep")
		else:
			timer.wait_time = 2
			add_child(timer)
			timer.start()
			$CanvasLayer/NoRoomMessage.show()
	pass # Replace with function body.
