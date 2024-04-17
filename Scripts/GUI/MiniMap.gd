extends ViewportContainer

var scene
var mapPinPath = "res://Scenes/Map/Minimap/MapPin.tscn"

#Camera
var cameraPath
var cameraZoom
var cameraPosition
onready var camSprite=$Viewport/CamSprite

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




func _physics_process(delta):
	cameraResize()
	mapPinUpdater()


func _ready():
	scene = get_tree().current_scene 
	mapSize = scene.get_node("Map").get_size() * scene.get_node("Map").get_scale()
	mapScaledDifference = self.get_size() / mapSize
	cameraPath = scene.get_node("PlayerCam")
	structurePath = scene.get_node("Structures")
	enemyUnitPath = scene.get_node("EnemyUnits")
	friendlyUnitPath = scene.get_node("FriendlyUnits")
	ressourcePath = scene.get_node("Resources")
	elementCreator()

func cameraResize():
	cameraZoom = cameraPath.zoom
	cameraPosition = cameraPath.position 
	camSprite.scale = get_viewport().size * cameraPath.zoom / camSprite.texture.get_size() * mapScaledDifference
	camSprite.position = cameraPosition * mapScaledDifference

func elementCreator():
		for ressource in ressourcePath.get_children():
			match ressource.itemType:
				"Wood":
					mapPinCreator(ressource.position, "res://Assets/Images/Icons/tree.png", "Ressource")
				"Stone":
					mapPinCreator(ressource.position, "res://Assets/Images/Icons/stone.png", "Ressource")
				"Food":
					mapPinCreator(ressource.position, "res://Assets/Images/Icons/food.png", "Ressource")
					
		for unit in friendlyUnitPath.get_children():
			mapPinCreator(unit.position, "res://Assets/Images/Icons/monkey_banana.png", "Friendly")
			
		for unit in enemyUnitPath.get_children():
			mapPinCreator(unit.position, "res://Assets/Images/Icons/monkey_banana.png", "Enemy")
			
		for structure in structurePath.get_children():
			mapPinCreator(structure.position, "res://Assets/Images/Icons/monkey_banana.png", "Structure")
			

func mapPinCreator(var pos, var img, var loc):
	var newMapPin = load(mapPinPath).instance()
	newMapPin.position = pos * mapScaledDifference
	newMapPin.texture = load(img)
	newMapPin.scale = mapScaledDifference
	$Viewport.get_node(loc).add_child(newMapPin)

func mapPinUpdater():
	if $Viewport/Friendly.get_child_count() == friendlyUnitPath.get_child_count():
		for mapPin in $Viewport/Friendly.get_child_count():
			$Viewport/Friendly.get_child(mapPin).position = friendlyUnitPath.get_child(mapPin).position * mapScaledDifference
		for mapPin in $Viewport/Enemy.get_child_count():
			$Viewport/Enemy.get_child(mapPin).position = enemyUnitPath.get_child(mapPin).position * mapScaledDifference

