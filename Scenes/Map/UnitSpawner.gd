extends Area2D
onready var GlobalVariable = get_node("/root/GlobalVariables")

var previewUnitInstance
var unitMode = false
var placeableUnit = false
var unitPlaced

func _ready():
	pass

func _on_Timer_timeout():
	$CanvasLayer/NoRoomMessage.hide()
	# Do something when the timer times out

func addPreviewUnit():
	add_child(previewUnitInstance)
	#previewUnitInstance.hide()
	
func previewUnitRemove():
	$CollisionShape2D.set_disabled(false)
	previewUnitInstance.queue_free()
	pass

func togglePreviewVisibility():
	if unitMode == true:
		if unitPlaced == false:
			$CollisionShape2D.set_disabled(true)
		
		var overlapping = false
		var sprite = previewUnitInstance.get_node("Sprite")
		var mousePos = get_global_mouse_position()
		previewUnitInstance.position = mousePos
		
		for body in get_overlapping_bodies():
			if body.is_in_group("Unit") or body.is_in_group("Terrain"):
				placeableUnit = false
				sprite.modulate = Color(1, 0, 0)
				overlapping = true
				break
		if not overlapping:
			placeableUnit = true
			sprite.modulate = Color(0, 1, 0)

func _input(event):
	if event is InputEventMouseMotion and unitMode:
		togglePreviewVisibility()
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if unitMode and placeableUnit:
			spawnUnit()

func _on_PurchaseSword_pressed():
	previewUnitInstance = load("res://Scenes/Units/FriendlyUnitTypes/FriendlySpearman.tscn").instance()
	addPreviewUnit()
	unitMode = true

func _on_PurchaseMiner_pressed():
	# Logic for miner purchase
	pass

func notBuild():
	if Input.is_action_just_released("rightClick"):
		previewUnitInstance.queue_free()
		unitMode = false
		print("WARNO TIME PLS")


func spawnUnit():
	var res = GlobalVariable.VikingRts.resources
	if res.food >= 15 and res.wood >= 8:
		var newUnit = load("res://Scenes/Units/FriendlyUnitTypes/FriendlySpearman.tscn").instance()
		newUnit.position = get_global_mouse_position()
		newUnit.add_to_group("Unit")
		newUnit.add_to_group("friendlyUnit")
		get_tree().current_scene.get_node("FriendlyUnits").add_child(newUnit)
		res.food -= 15
		res.wood -= 8
		previewUnitRemove()
		unitMode = false
	else:
		# Show message or handle lack of resources
		pass
