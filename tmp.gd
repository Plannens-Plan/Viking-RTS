extends Area2D
var unitsInside = false

onready var GlobalVariable = get_node("/root/GlobalVariables")

func _ready():
	pass

#func unitCollision():
#	var overlapping = false
#	if get_overlapping_bodies().size() > 0:
#		for body in get_overlapping_bodies():
#			if body.is_in_group("unit"):
#				print("BRUUUH")
#				unitsInside = true
#				overlapping = true
#			else:
#				print("balls")
#				unitsInside = false
#				overlapping = false
#	else:
#		unitsInside = false
#		overlapping = false

func _on_Timer_timeout():
	$CanvasLayer/NoRoomMessage.hide()
	# Do something when the timer times out




var previewUnit
var unitMode
var placeableUnit

func addPreview():
	add_child(previewUnit)
	previewUnit.hide()

func previewUnit():
	#add_child(previewBuilding)
	previewUnit.set_visible(true)
	var mousePos = get_global_mouse_position()
	previewUnit.position = mousePos
	
	var overlapping = false
	var sprite = previewUnit.get_node("Sprite")
	if previewUnit is Area2D:
		for area in previewUnit.get_overlapping_areas():
			if area.is_in_group("Unit") || area.is_in_group("Terrain"):
				placeableUnit = false
				sprite.modulate = Color(1, 0, 0)
				overlapping = true
		if not overlapping:
				placeableUnit = true
				sprite.modulate = Color(0, 1, 0)

func notBuild():
	if(Input.is_action_just_released("rightClick")):
		previewUnit.set_visible(false)
		previewUnit.queue_free()
		unitMode = !unitMode 
		print("WARNO TIME PLS")





func _on_PurchaseSword_pressed():
	previewUnit = load("res://Scenes/Units/FriendlyUnitTypes/FriendlySpearman.tscn").instance()
	
	addPreview()
	unitMode = true
	previewUnit()
	notBuild()
#	unitCollision()
	var timer
	timer = Timer.new()
	timer.connect("timeout", self, "_on_Timer_timeout")
	var res=GlobalVariable.VikingRts.resources
	if res.food >= 15 and res.wood >= 8 and unitMode == true:
		if(Input.is_action_just_released("leftClick") && placeableUnit == true):
			var troop = load("res://Scenes/Units/FriendlyUnitTypes/FriendlySpearman.tscn").instance()
			var mousePos = get_global_mouse_position()
			troop.position = mousePos
			troop.add_to_group("Unit")
			troop.add_to_group("friendlyUnit")
			res.food-=15
			res.wood-=8
			var scene=get_tree().current_scene
			scene.get_node("FriendlyUnits").add_child(troop)
			unitMode = false
		
		
#		if unitsInside == false:
#			var troop = load("res://Scenes/Units/FriendlyUnitTypes/FriendlySpearman.tscn").instance()
#			res.food-=15
#			res.wood-=8
#			troop.position = position
#			var scene=get_tree().current_scene
#			scene.get_node("FriendlyUnits").add_child(troop)
#			unitMode = false
		else:
			timer.wait_time = 2
			add_child(timer)
			timer.start()
			$CanvasLayer/NoRoomMessage.show()
			print("bruh")

func _on_PurchaseMiner_pressed():
	var timer
	timer = Timer.new()
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	var res=GlobalVariable.VikingRts.resources
	if res.food >= 10 and res.wood >= 10:
		if unitsInside == false:
			var troop = load("res://Scenes/Units/FriendlyUnitTypes/FriendlyThrall.tscn").instance()
			res.food-=10
			res.wood-=10
			troop.position = position
			var scene=get_tree().current_scene
			scene.get_node("FriendlyUnits").add_child(troop)
			print("yep")
		else:
			timer.wait_time = 2
			add_child(timer)
			timer.start()
			$CanvasLayer/NoRoomMessage.show()
