extends Node2D

var sprite
var shownObject
var spriteWidth
var spriteHeight

var collisionScaleX
var collisionScaleY

var placable = false

# The type of object being previewed
var previewingUnit = false
var previewingStructure = false

var sadasd = 0

func _ready():
	$Sprite.texture = sprite
	$Sprite.scale.x = spriteWidth
	$Sprite.scale.y = spriteHeight
	$placableDetect/CollisionShape2D.scale.x = collisionScaleX
	$placableDetect/CollisionShape2D.scale.y = collisionScaleY





func _physics_process(delta):
	position = get_global_mouse_position()
	if previewingUnit == false:
		if $placableDetect.get_overlapping_areas().size() > 0:
			for area in $placableDetect.get_overlapping_areas():
				if area.is_in_group("Building") || area.is_in_group("Terrain") :
					$Sprite.modulate = Color(1, 0, 0)
					placable = false
			for area in $placableDetect.get_overlapping_bodies():
				if area.is_in_group("unit") :
					$Sprite.modulate = Color(1, 0, 0)
					placable = false
		else:
			$Sprite.modulate = Color(0, 1, 0)
			print("NONONONON")
			placable = true
	elif previewingUnit == true:
		if previewingUnit == true && $placableDetect.get_overlapping_areas().size() > 0:
			for area in $placableDetect.get_overlapping_areas():
				if area.is_in_group("unitSpawnArea"):
					print("HAHAHAHAHAHHA")
					$Sprite.modulate = Color(0, 1, 0)
					placable = true
		else:
			$Sprite.modulate = Color(1, 0, 0)
			print("NONONONON")
			placable = false

func _input(event):
	if event is InputEventMouseButton and event.get_button_index() == 1 and placable:
		var scene = get_tree().current_scene
		var newObject = shownObject.instance()
		if previewingUnit:
			newObject.position = position
			scene.get_node("FriendlyUnits").add_child(newObject)
			queue_free()
		if previewingStructure:
			newObject.position = position
			scene.get_node("Structures").get_node("Friendly").add_child(newObject)
			queue_free()
