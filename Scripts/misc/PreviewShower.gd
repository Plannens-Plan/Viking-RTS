extends Node2D
onready var GlobalVariable = get_node("/root/GlobalVariables")

var sprite
var shownObject
var spriteWidth
var spriteHeight

var collisionScaleRadius
var collisionScaleX
var collisionScaleY

var woodCost = 0
var stoneCost = 0
var foodCost = 0
var silverCost = 0

var placable = false
var unitPlacable = false

# The type of object being previewed
var previewingUnit = false
var previewingStructure = false

func _ready():
	print(collisionScaleX)
	$Sprite.texture = sprite
	$Sprite.scale.x = spriteWidth
	$Sprite.scale.y = spriteHeight
	if collisionScaleX != null:
		print("not balls")
		var rect = RectangleShape2D.new()
		rect.extents = Vector2(collisionScaleX,collisionScaleY)
		$placableDetect/CollisionShape2D.shape = rect
		
	if collisionScaleRadius != null:
		print("balls")
		var circle = CircleShape2D.new()
		circle.radius = collisionScaleRadius
		$placableDetect/CollisionShape2D.shape = circle

func _physics_process(delta):
	position = get_global_mouse_position()
	if previewingUnit == false:
		if $placableDetect.get_overlapping_areas().size() > 0 || $placableDetect.get_overlapping_bodies().size() > 0:
			var obstacle = 0
			for area in $placableDetect.get_overlapping_areas():
				if area.is_in_group("Building") || area.is_in_group("Terrain") :
					print(area.get_groups())
					obstacle += 1
			for bodies in $placableDetect.get_overlapping_bodies():
				if bodies.is_in_group("unit") :
					obstacle += 1
			if obstacle > 0:
				placable = false
			else:
				placable = true
		else:
			placable = true
		if placable == true:
			$Sprite.modulate = Color(0, 1, 0)
		else:
			$Sprite.modulate = Color(1, 0, 0)
	
	
	
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
			if $placableDetect.get_overlapping_areas().size() > 0 || $placableDetect.get_overlapping_bodies() > 0:
				var obstacle = 0
				for area in $placableDetect.get_overlapping_areas():
					if area.is_in_group("Building") || area.is_in_group("Terrain"):
						obstacle+=1
				for bodies in $placableDetect.get_overlapping_bodies():
					if bodies.is_in_group("unit") :
						obstacle += 1
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
	var resources = GlobalVariable.VikingRts.resources
	if event is InputEventMouseButton && event.get_button_index() == 1 && placable == true:
		var scene = get_tree().current_scene
		var newObject = shownObject.instance()
		if previewingUnit:
			newObject.position = position
			scene.get_node("FriendlyUnits").add_child(newObject)
			queue_free()
		if previewingStructure:
			if resources.food >= foodCost and resources.wood >= woodCost and resources.stone >= stoneCost and resources.silver >= silverCost:
				newObject.position = position
				scene.get_node("Structures").get_node("Friendly").add_child(newObject)
				resources.wood -= woodCost
				resources.stone -= stoneCost
				resources.food -= foodCost
				resources.silver -= silverCost
			queue_free()
