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

func _ready():
	$Sprite.texture = sprite
	$Sprite.scale.x = spriteWidth
	$Sprite.scale.y = spriteHeight
	$placableDetect/CollisionShape2D.scale.x = collisionScaleX
	$placableDetect/CollisionShape2D.scale.y = collisionScaleY

func _physics_process(delta):
	position = get_global_mouse_position()
	if $placableDetect.get_overlapping_areas().size() > 0:
		for area in $placableDetect.get_overlapping_areas():
			if area.is_in_group("Building") || area.is_in_group("Terrain"):
				$Sprite.modulate = Color(1, 0, 0)
				placable = false
	else:
		$Sprite.modulate = Color(0, 1, 0)
		placable = true
	
func _input(event):
	if event is InputEventMouseButton and event.get_button_index() == 1 and placable:
		var scene = get_tree().current_scene
		if previewingUnit:
			scene.get_node("FriendlyUnits").add_child(shownObject)
			shownObject.position = position
			queue_free()
		if previewingStructure:
			scene.get_node("Friendly").add_child(shownObject)
			shownObject.position = position
			queue_free()
