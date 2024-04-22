extends ViewportContainer

var scene
var mapPinPath = "res://Scenes/Map/Minimap/MapPin.tscn"

#Camera
var cameraPath
var cameraZoom
var cameraPosition
onready var camSprite=$Viewport/CamSprite
var cameraSpritePosition = Vector2(0,0)

#Map
var mapSize = Vector2(2560,1440)
var mapScaledDifference
var mapPin
var mapPinMapScaler


var scaler = Vector2(400,400)
var areaStartingPosition = Vector2(100,100)
var camDrag
var camDragPosition = Vector2(0,0)

var ammount
onready var loc = $Viewport/Friendly

#en X del af skærmen (skærm/X=minimap Størrelse
var screenSize = 5.5


func _physics_process(delta):
	updateScene()
	minimapResizer()
	cameraResize()
	mapPinBuilder()
	mapPinUpdater()
	camDragger()


func cameraResize():
	cameraZoom = cameraPath.zoom
	cameraPosition = cameraPath.position 
	camSprite.scale = get_viewport().size * cameraPath.zoom / camSprite.texture.get_size() * mapScaledDifference
	cameraSpritePosition = cameraPosition * mapScaledDifference
	cameraSpritePosition.x = clamp(cameraSpritePosition.x, 0 + $Viewport/CamSprite.get_texture().get_size().x / 2 * $Viewport/CamSprite.scale.x, mapSize.x*mapScaledDifference.x - $Viewport/CamSprite.get_texture().get_size().x / 2 * $Viewport/CamSprite.scale.x)
	cameraSpritePosition.y = clamp(cameraSpritePosition.y, 0 + $Viewport/CamSprite.get_texture().get_size().y / 2 * $Viewport/CamSprite.scale.y, mapSize.y*mapScaledDifference.y - $Viewport/CamSprite.get_texture().get_size().y / 2 * $Viewport/CamSprite.scale.y)
	camSprite.position = cameraSpritePosition


func mapPinCreator(var pos,var img,var loc):
	var newMapPin = load(mapPinPath).instance()
	newMapPin.position = pos * mapScaledDifference
	newMapPin.texture = load(img)
	newMapPin.scale = scaler/load(img).get_size() * mapPinMapScaler
	loc.add_child(newMapPin)


func mapPinUpdater():
	#Friendly
	subMapPinUpdater(scene,"FriendlyUnits",$Viewport/Friendly)
	
	#Enemy
	subMapPinUpdater(scene,"EnemyUnits",$Viewport/Enemy)
	
	#Neutral
	subMapPinUpdater(scene, "NeutralUnits", $Viewport/Neutral)
	
	#Resource
	if scene.has_node("Resources"):
		subMapPinUpdater(scene.get_node("Resources"),"Wood", $Viewport/Resource/Wood)
		subMapPinUpdater(scene.get_node("Resources"),"Food", $Viewport/Resource/Food)
		subMapPinUpdater(scene.get_node("Resources"),"Stone", $Viewport/Resource/Stone)
	
	#Structures
	if scene.has_node("Structures"):
		subMapPinUpdater(scene.get_node("Structures"),"Friendly",$Viewport/Structure/Friendly)
		subMapPinUpdater(scene.get_node("Structures"),"Enemy",$Viewport/Structure/Enemy)


func subMapPinUpdater(var getMainNode, var sceneChildCounter, var localNode):
	if getMainNode.has_node(sceneChildCounter):
		if localNode.get_child_count() == getMainNode.get_node(sceneChildCounter).get_child_count():
			for mapPin in localNode.get_child_count():
				localNode.get_child(mapPin).position = getMainNode.get_node(sceneChildCounter).get_child(mapPin).position * mapScaledDifference
				localNode.get_child(mapPin).scale = scaler / localNode.get_child(mapPin).get_texture().get_size() * mapPinMapScaler
	pass


func updateScene():
	scene = get_tree().current_scene 
	mapSize = scene.get_node("Map").get_size() * scene.get_node("Map").get_scale()
	cameraPath = scene.get_node("PlayerCam")
	mapScaledDifference = self.rect_size / mapSize
	if mapScaledDifference.x > mapScaledDifference.y:
		mapPinMapScaler =  mapScaledDifference.y
	else:
		mapPinMapScaler =  mapScaledDifference.x
	$Viewport/Background.texture = scene.get_node("Map").get_texture()


func minimapResizer():
	$Viewport.size = get_viewport().size / screenSize
	self.rect_size = $Viewport.size
	$Viewport/Background.scale = $Viewport.size  / $Viewport/Background.get_texture().get_size() #* mapScaledDifference
	$Area2D/CollisionShape2D.position = $Viewport.size/2
	$Area2D/CollisionShape2D.scale = $Viewport.size/areaStartingPosition/2


func mapPinBuilder():
	#Friendly
	subMapPinBuilder(scene, "FriendlyUnits", "res://Assets/Images/Icons/FriendlyUnit.png", $Viewport/Friendly)
	#Enemy
	subMapPinBuilder(scene, "EnemyUnits", "res://Assets/Images/Icons/EnemyUnit.png", $Viewport/Enemy)
	#Neutral
	subMapPinBuilder(scene, "NeutralUnits", "res://Assets/Images/Icons/Monk marker.png", $Viewport/Neutral)
	#Ressource (ændre maybe til at den er lidt pænerer
	if scene.has_node("Resources"):
		subMapPinBuilder(scene.get_node("Resources"),"Wood", "res://Assets/Images/Icons/WoodMarker.png", $Viewport/Resource/Wood)
		subMapPinBuilder(scene.get_node("Resources"),"Food", "res://Assets/Images/Icons/FoodMarker.png", $Viewport/Resource/Food)
		subMapPinBuilder(scene.get_node("Resources"),"Stone", "res://Assets/Images/Icons/StoneMarker.png", $Viewport/Resource/Stone)
	#Structure
	if scene.has_node("Structures"):
		subMapPinBuilder(scene.get_node("Structures"), "Friendly", "res://Assets/Images/Icons/FriendlyStructureMarker.png",$Viewport/Structure/Friendly)
		subMapPinBuilder(scene.get_node("Structures"), "Enemy","res://Assets/Images/Icons/EnemyStructureMarker.png",$Viewport/Structure/Enemy)


func subMapPinBuilder(var getSceneNode, var sceneChildCounter, var img, var localNode):
	if getSceneNode.has_node(sceneChildCounter):
		ammount = localNode.get_child_count() - getSceneNode.get_node(sceneChildCounter).get_child_count()
		if ammount < 0:
			mapPinCreator(Vector2(0,0), img, localNode)
		if ammount > 0:
			localNode.get_child(0).queue_free()


func camDragger():
	
	if Input.is_action_just_pressed("leftClick") && get_global_mouse_position().x - rect_global_position.x < get_viewport().size.x / screenSize && get_global_mouse_position().y - get_global_rect().position.x < get_viewport().size.y / screenSize && get_global_mouse_position().x - get_global_rect().position.x > 0 && get_global_mouse_position().y - get_global_rect().position.y > 0:
		camDrag=true
		scene.get_node("selection").selectionStopper = true
		
	if Input.is_action_just_released("leftClick"):
		camDrag = false
		scene.get_node("selection").selectionStopper = false
		
		
	if camDrag==true:
		camDragPosition = get_local_mouse_position() / mapScaledDifference
		camDragPosition.x = clamp (camDragPosition.x,0,mapSize.x)
		camDragPosition.y = clamp (camDragPosition.y,0,mapSize.y)
		scene.get_node("PlayerCam").position = camDragPosition
