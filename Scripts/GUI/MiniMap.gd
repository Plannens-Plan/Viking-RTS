extends ViewportContainer

var scene

#Camera
var cameraPath
var cameraZoom
var cameraPosition
onready var camSprite=$Viewport/CamSprite

#Unit
var unitPath
var unitPosition

#Structure
var structurePath
var structurePosition

#Map
var mapSize = Vector2(2560,1440)
var mapScaledDifference

func _physics_process(delta):
	cameraResize()


func _ready():
	scene = get_tree().current_scene 
	mapSize = scene.get_node("Map").get_size() * scene.get_node("Map").get_scale()
	mapScaledDifference = self.get_size() / mapSize
	cameraPath = scene.get_node("PlayerCam")
	pass 


func cameraResize():
	cameraZoom = cameraPath.zoom
	cameraPosition = cameraPath.position 
	camSprite.scale = get_viewport().size * cameraPath.zoom / camSprite.texture.get_size() * mapScaledDifference
	camSprite.position = cameraPosition * mapScaledDifference

