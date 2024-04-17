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
	updateScene()
	cameraResize()
	mapPinBuilder()
	mapPinUpdater()
	print(mapSize)


func cameraResize():
	cameraZoom = cameraPath.zoom
	cameraPosition = cameraPath.position 
	camSprite.scale = get_viewport().size * cameraPath.zoom / camSprite.texture.get_size() * mapScaledDifference
	camSprite.position = cameraPosition * mapScaledDifference

func elementCreator():
		for ressource in ressourcePath.get_children():
			match ressource.itemType:
				"Wood":
					mapPinCreator(ressource.position, "res://Assets/Images/Icons/tree.jpg", "Ressource")
				"Stone":
					mapPinCreator(ressource.position, "res://Assets/Images/Icons/stone.jpg", "Ressource")
				"Food":
					mapPinCreator(ressource.position, "res://Assets/Images/Icons/food.jpg", "Ressource")
					
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
	if $Viewport/Enemy.get_child_count() == enemyUnitPath.get_child_count():
		for mapPin in $Viewport/Enemy.get_child_count():
			$Viewport/Enemy.get_child(mapPin).position = enemyUnitPath.get_child(mapPin).position * mapScaledDifference


func updateScene():
	scene = get_tree().current_scene 
	mapSize = scene.get_node("Map").get_size() * scene.get_node("Map").get_scale()
	mapScaledDifference = self.get_size() / mapSize
	cameraPath = scene.get_node("PlayerCam")
	structurePath = scene.get_node("Structures")
	enemyUnitPath = scene.get_node("EnemyUnits")
	friendlyUnitPath = scene.get_node("FriendlyUnits")
	ressourcePath = scene.get_node("Resources")


var ammount

func mapPinBuilder():
	
	#Friendly
	ammount = $Viewport/Friendly.get_child_count() - friendlyUnitPath.get_child_count()
	if ammount < 0:
		mapPinCreator(Vector2(0,0), "res://Assets/Images/Icons/monkey_banana.png", "Friendly")
	if ammount > 0:
		$Viewport/Friendly.get_child(0).queue_free()
		
		#Enemy
	ammount = $Viewport/Enemy.get_child_count() - enemyUnitPath.get_child_count()
	if ammount < 0:
		mapPinCreator(Vector2(0,0), "res://Assets/Images/Icons/monkey_banana.png", "Enemy")
	if ammount > 0:
		$Viewport/Enemy.get_child(0).queue_free()
	
	#Ressource (ændre maybe til at den er lidt pænerer
		ammount = $Viewport/Ressource.get_child_count() - ressourcePath.get_child_count()
	if ammount < 0:
		mapPinCreator(Vector2(0,0), "res://Assets/Images/Icons/monkey_banana.png", "Ressource")
	if ammount > 0:
		$Viewport/Ressource.get_child(0).queue_free()
	
	#Structure
		ammount = $Viewport/Structure.get_child_count() - structurePath.get_child_count()
	if ammount < 0:
		mapPinCreator(Vector2(0,0), "res://Assets/Images/Icons/monkey_banana.png", "Structure")
	if ammount > 0:
		$Viewport/Structure.get_child(0).queue_free()



#	ammount = $Viewport/Enemy.get_child_count() - enemyUnitPath.get_child_count()
#	for pin in ammount:
#		if pin > 0:
#			$Viewport/Enemy.get_child(pin).queue_free()
#		if pin < 0:
#			mapPinCreator(Vector2(0,0), "res://Assets/Images/Icons/monkey_banana.png", "Enemy")
#
#
#
#
#
#
#	for pin in $Viewport/Enemy.get_child_count() > enemyUnitPath.get_child_count():
#		if pin > 0:
#			$Viewport/Enemy.remove_child(pin)
#
#	for pin in $Viewport/Structure.get_child_count() > structurePath.get_child_count():
#		if pin > 0:
#			$Viewport/Structure.remove_child(pin)
#
#	for pin in $Viewport/Ressource.get_child_count() > ressourcePath.get_child_count():
#		if pin > 0:
#			$Viewport/Ressource.remove_child(pin)
#
#	#adder
#	for pin in $Viewport/Friendly.get_child_count() < friendlyUnitPath.get_child_count():
#		if pin > 0:
#			mapPinCreator(Vector2(0,0), "res://Assets/Images/Icons/monkey_banana.png", "Friendly")
#
#	for pin in $Viewport/Enemy.get_child_count() < enemyUnitPath.get_child_count():
#		if pin > 0:
#			mapPinCreator(Vector2(0,0), "res://Assets/Images/Icons/monkey_banana.png", "Enemy")
#
#	for pin in $Viewport/Structure.get_child_count() < structurePath.get_child_count():
#		if pin > 0:
#			mapPinCreator(Vector2(0,0), "res://Assets/Images/Icons/monkey_banana.png", "Structure")
#
#	for pin in $Viewport/Ressource.get_child_count() < ressourcePath.get_child_count():
#		if pin > 0:
#			mapPinCreator(Vector2(0,0), "res://Assets/Images/Icons/monkey_banana.png", "Ressource")
