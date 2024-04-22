extends "res://Scripts/Structures/FriendlyStructure.gd"

#var overlap = get_node("CollisionShape2D")
var unitsInside = false

onready var GlobalVariable = get_node("/root/GlobalVariables")

func _ready():
	health = 1000
	maxHealth = 1000
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

func buyUnit(var unitScene, var foodCost, var woodCost, var stoneCost, var silverCost):
	unitCollision()
	var timer
	timer = Timer.new()
	timer.connect("timeout", self, "_on_Timer_timeout")
	var res = GlobalVariable.VikingRts.resources
	if res.food >= foodCost and res.wood >= woodCost and res.stone >= stoneCost and res.silver >= silverCost:
		if unitsInside == false:
			var troop = unitScene.instance()
			res.food -= foodCost
			res.wood -= woodCost
			res.stone -= stoneCost
			res.silver -= silverCost
			troop.position = Vector2(position.x - 485 * $Sprite.scale.x, position.y + 330 * $Sprite.scale.y)
			var scene = get_tree().current_scene
			scene.get_node("FriendlyUnits").add_child(troop)
		else:
			timer.wait_time = 2
			add_child(timer)
			timer.start()
			$CanvasLayer/NoRoomMessage.show()

func _on_Timer_timeout():
	$CanvasLayer/NoRoomMessage.hide()
	# Do something when the timer times out

func _on_PurchaseSpear_pressed():
	buyUnit(load("res://Scenes/Units/FriendlyUnitTypes/FriendlySpearman.tscn"), 75, 25, 0, 25)

func _on_PurchaseAxe_pressed():
	buyUnit(load("res://Scenes/Units/FriendlyUnitTypes/FriendlyAxeman.tscn"), 125, 10, 0, 35)

func _on_PurchaseBow_pressed():
	buyUnit(load("res://Scenes/Units/FriendlyUnitTypes/FriendlyArcher.tscn"), 50, 75, 25, 50)

func _on_PurchaseThrall_pressed():
	buyUnit(load("res://Scenes/Units/FriendlyUnitTypes/FriendlyThrall.tscn"), 50, 25, 50, 0)
