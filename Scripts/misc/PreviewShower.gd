extends Node2D

var sprite
var shownObject
var spriteWidth
var spriteHeight

var collisionScaleRadius
var collisionScaleX
var collisionScaleY


var placable = false
var unitPlacable = false

# The type of object being previewed
var previewingUnit = false
var previewingStructure = false

var sadasd = 0

func _ready():
	$Sprite.texture = sprite
	$Sprite.scale.x = spriteWidth
	$Sprite.scale.y = spriteHeight
	if collisionScaleX != null:
		$placableDetect/CollisionShape2D.shape = RectangleShape2D
		$placableDetect/CollisionShape2D.shape.extents.x = collisionScaleX
		$placableDetect/CollisionShape2D.shape.extents.y = collisionScaleY
	if collisionScaleRadius != null:
		$placableDetect/CollisionShape2D.shape = CircleShape2D
		$placableDetect/CollisionShape2D.shape.radius = collisionScaleRadius

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
		else:
			$Sprite.modulate = Color(0, 1, 0)
			placable = true
	elif previewingUnit == true:
		if $placableDetect.get_overlapping_areas().size() > 0:
			var unitSpawnArea = 0
			for area in $placableDetect.get_overlapping_areas():
				if area.is_in_group("unitSpawnArea"):
					unitSpawnArea=+1
			if unitSpawnArea > 0:
				unitPlacable=true
			else:
				unitPlacable=false
		else:
			unitPlacable=false
		if unitPlacable == true:
			if $placableDetect.get_overlapping_areas().size() > 0:
				var obstacle = 0
				for area in $placableDetect.get_overlapping_areas():
					if area.is_in_group("Building") || area.is_in_group("Terrain"):
						obstacle=+1
				if obstacle > 0:
					placable=false
				else:
					placable=true
			
		else:
			placable = false
		if placable == true:
			$Sprite.modulate = Color(0, 1, 0)
		else:
			$Sprite.modulate = Color(1, 0, 0)

func _input(event):
	if event is InputEventMouseButton && event.get_button_index() == 1 && placable == true:
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
