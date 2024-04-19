extends "res://Scripts/Structures/FriendlyStructure.gd"

#var overlap = get_node("CollisionShape2D")
var unitsInside = false

onready var GlobalVariable = get_node("/root/GlobalVariables")

func _ready():
	health = 500
	maxHealth = 500
	updateElements()

func _physics_process(delta):
	if selected:
		$Panel.visible = true
	else:
		$Panel.visible = false

func unitCollision():
	var overlapping = false
	if get_overlapping_bodies().size() > 0:
		for body in get_overlapping_bodies():
			if body.is_in_group("unit"):
				print("BRUUUH")
				unitsInside = true
				overlapping = true
			else:
				print("balls")
				unitsInside = false
				overlapping = false
	else:
		unitsInside = false
		overlapping = false

func _on_Timer_timeout():
	$CanvasLayer/NoRoomMessage.hide()
	# Do something when the timer times out

func _on_PurchaseSpear_pressed():
	unitCollision()
	var timer
	timer = Timer.new()
	timer.connect("timeout", self, "_on_Timer_timeout")
	var res=GlobalVariable.VikingRts.resources
	if res.food >= 15 and res.wood >= 8:
		if unitsInside == false:
			var troop = load("res://Scenes/Units/FriendlyUnitTypes/FriendlySpearman.tscn").instance()
			res.food-=15
			res.wood-=8
			troop.position = position
			var scene = get_tree().current_scene
			scene.get_node("FriendlyUnits").add_child(troop)
		else:
			timer.wait_time = 2
			add_child(timer)
			timer.start()
			$CanvasLayer/NoRoomMessage.show()
			print("bruh")

func _on_PurchaseThrall_pressed():
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
			var scene = get_tree().current_scene
			scene.get_node("FriendlyUnits").add_child(troop)
			print("yep")
		else:
			timer.wait_time = 2
			add_child(timer)
			timer.start()
			$CanvasLayer/NoRoomMessage.show()
