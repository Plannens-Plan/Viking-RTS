extends ViewportContainer

var scene
var mapPinPath = "res://Scenes/Map/Minimap/MapPin.tscn"

#Camera
var cameraPath
var cameraZoom
var cameraPosition
onready var camSprite=$Viewport/CamSprite
var cameraSpritePosition = Vector2(0,0)

#Unit
var unitPath
var unitPosition
var friendlyUnitPath
var enemyUnitPath

#Structure
var structurePath
var structurePosition

#Ressource
var ressourcePath
var ressourcePosition

#Map
var mapSize = Vector2(2560,1440)
var mapScaledDifference
var mapPin


var scaler = Vector2(400,400)
var areaStartingPosition = Vector2(100,100)
var camDrag
var camDragPosition = Vector2(0,0)

#en X del af skærmen (skærm/X=minimap Størrelse
var screenSize = 5.5


func _physics_process(delta):
	updateScene()
	minimapResizer()
	cameraResize()
	mapPinBuilder()
	mapPinUpdater()
	camDragger()
	print($Viewport/Friendly.get_child_count())





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
	newMapPin.scale = scaler/load(img).get_size() * mapScaledDifference
	loc.add_child(newMapPin)





func mapPinUpdater():
	#Friendly
	if scene.has_node("FriendlyUnits"):
		if $Viewport/Friendly.get_child_count() == friendlyUnitPath.get_child_count():
			for mapPin in $Viewport/Friendly.get_child_count():
				$Viewport/Friendly.get_child(mapPin).position = friendlyUnitPath.get_child(mapPin).position * mapScaledDifference
				$Viewport/Friendly.get_child(mapPin).scale = scaler / $Viewport/Friendly.get_child(mapPin).get_texture().get_size() * mapScaledDifference
			
	#Enemy
	if scene.has_node("EnemyUnits"):
		if $Viewport/Enemy.get_child_count() == enemyUnitPath.get_child_count():
			for mapPin in $Viewport/Enemy.get_child_count():
				$Viewport/Enemy.get_child(mapPin).position = enemyUnitPath.get_child(mapPin).position * mapScaledDifference
				$Viewport/Enemy.get_child(mapPin).scale = scaler / $Viewport/Enemy.get_child(mapPin).get_texture().get_size() * mapScaledDifference
			
	#Structures
	if scene.has_node("Structures"):
		if scene.get_node("Structures").has_node("Friendly"):
			if $Viewport/Structure/Friendly.get_child_count() == structurePath.get_node("Friendly").get_child_count():
				for mapPin in $Viewport/Structure/Friendly.get_child_count():
					$Viewport/Structure/Friendly.get_child(mapPin).position = structurePath.get_node("Friendly").get_child(mapPin).position * mapScaledDifference
					$Viewport/Structure/Friendly.get_child(mapPin).scale = scaler / $Viewport/Structure/Friendly.get_child(mapPin).get_texture().get_size() * mapScaledDifference
		
		if scene.get_node("Structures").has_node("Enemy"):
			if $Viewport/Structure/Enemy.get_child_count() == structurePath.get_node("Enemy").get_child_count():
				for mapPin in $Viewport/Structure/Enemy.get_child_count():
					$Viewport/Structure/Enemy.get_child(mapPin).position = structurePath.get_node("Enemy").get_child(mapPin).position * mapScaledDifference
					$Viewport/Structure/Enemy.get_child(mapPin).scale = scaler / $Viewport/Structure/Enemy.get_child(mapPin).get_texture().get_size() * mapScaledDifference
			
	#Ressource
	if scene.has_node("Resources"):
		if $Viewport/Ressource.get_child_count() == ressourcePath.get_child_count():
			for mapPin in $Viewport/Ressource.get_child_count():
				$Viewport/Ressource.get_child(mapPin).position = ressourcePath.get_child(mapPin).position * mapScaledDifference
				$Viewport/Ressource.get_child(mapPin).scale = scaler / $Viewport/Ressource.get_child(mapPin).get_texture().get_size() * mapScaledDifference






func updateScene():
	scene = get_tree().current_scene 
	mapSize = scene.get_node("Map").get_size() * scene.get_node("Map").get_scale()
	mapScaledDifference = self.rect_size / mapSize
	cameraPath = scene.get_node("PlayerCam")
	if scene.has_node("Structures"):
		structurePath = scene.get_node("Structures")
	if scene.has_node("EnemyUnits"):
		enemyUnitPath = scene.get_node("EnemyUnits")
	if scene.has_node("FriendlyUnits"):
		friendlyUnitPath = scene.get_node("FriendlyUnits")
	if scene.has_node("Resources"):
		ressourcePath = scene.get_node("Resources")
	$Viewport/Background.texture = scene.get_node("Map").get_texture()





func minimapResizer():
	$Viewport.size = get_viewport().size / screenSize
	self.rect_size = $Viewport.size
	$Viewport/Background.scale = $Viewport.size * 2 / $Viewport/Background.get_texture().get_size() #* mapScaledDifference
	$Area2D/CollisionShape2D.position = $Viewport.size/2
	$Area2D/CollisionShape2D.scale = $Viewport.size/areaStartingPosition/2



var ammount
onready var loc = $Viewport/Friendly


func mapPinBuilder():
	
	#Friendly
	subMapPinBuilder(scene, "FriendlyUnits", "res://Assets/Images/Icons/FriendlyUnit.png", $Viewport/Friendly)
	#Enemy
	subMapPinBuilder(scene, "EnemyUnits", "res://Assets/Images/Icons/EnemyUnit.png", $Viewport/Enemy)
	#Ressource (ændre maybe til at den er lidt pænerer
	subMapPinBuilder(scene, "Resources", "res://Assets/Images/Icons/WoodMarker.png", $Viewport/Ressource)
	#Structure
	if scene.has_node("Structures"):
		subMapPinBuilder(scene.get_node("Structures"), "Friendly", "res://Assets/Images/Icons/StructureMarker.png",$Viewport/Structure/Friendly)
		subMapPinBuilder(scene.get_node("Structures"), "Enemy","res://Assets/Images/Icons/monkey_banana.png",$Viewport/Structure/Enemy)


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
