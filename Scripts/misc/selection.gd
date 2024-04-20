extends Node2D
var massSelectionStartingPointX=null
var massSelectionStartingPointY=null
var held=false
var scalerx=null
var scalery=null
var selectionStopper = false
var mousePosition = Vector2(0,0)
var cam
var map

func _ready():
	$Sprite.hide()
	if get_tree().current_scene.has_node("PlayerCam"):
		cam = get_tree().current_scene.get_node("PlayerCam")
		#cam = null
	if get_tree().current_scene.has_node("Map"):
		map = get_tree().current_scene.get_node("Map")
		#cam = null

func _physics_process(delta):
	inputter()
	checker()

func inputter():
	if Input.is_action_just_pressed("select") && selectionStopper==false :
		held = true
		$Sprite.show()
	if Input.is_action_just_released("select"):
		held = false
		massSelectionStartingPointX = null
		massSelectionStartingPointY = null
		$Sprite.hide()
		$Area2D/CollisionShape2D.position=Vector2(0,0)
		$Area2D/CollisionShape2D.scale=Vector2(0,0)
		selector()

func checker():
	#print(cam)
	if held == true:
		if massSelectionStartingPointX == null && massSelectionStartingPointY == null:
			massSelectionStartingPointX = get_global_mouse_position().x as float
			massSelectionStartingPointY = get_global_mouse_position().y as float
		
		if cam!=null:
			mousePosition.x = clamp(get_global_mouse_position().x ,cam.position.x - get_viewport().size.x * cam.zoom.x/2 , get_viewport().size.x * cam.zoom.x/2 + cam.position.x)
			mousePosition.y = clamp(get_global_mouse_position().y ,cam.position.y - get_viewport().size.y * cam.zoom.y/2 , get_viewport().size.y * cam.zoom.y/2 + cam.position.y)
		else:
			mousePosition.x = get_global_mouse_position().x 
			mousePosition.y = get_global_mouse_position().y 
		
		if mousePosition.x > massSelectionStartingPointX:
			$Sprite.position.x = massSelectionStartingPointX
			scalerx = mousePosition.x - massSelectionStartingPointX
			$Sprite.scale.x = (scalerx / $Sprite.texture.get_width())
			$Area2D/CollisionShape2D.position.x = massSelectionStartingPointX + ($Sprite.scale.x * $Sprite.texture.get_width()) / 2
			$Area2D/CollisionShape2D.scale = $Sprite.scale
		
		elif mousePosition.x <= massSelectionStartingPointX:
			$Sprite.position.x = mousePosition.x
			scalerx = massSelectionStartingPointX - mousePosition.x
			$Sprite.scale.x = (scalerx / $Sprite.texture.get_width())
			$Area2D/CollisionShape2D.position.x = massSelectionStartingPointX - ($Sprite.scale.x * $Sprite.texture.get_width()) / 2
			$Area2D/CollisionShape2D.scale=$Sprite.scale
		
		if mousePosition.y > massSelectionStartingPointY:
			$Sprite.position.y = massSelectionStartingPointY
			scalery = mousePosition.y - massSelectionStartingPointY
			$Sprite.scale.y = (scalery / $Sprite.texture.get_height())
			$Area2D/CollisionShape2D.position.y = massSelectionStartingPointY + ($Sprite.scale.y * $Sprite.texture.get_height()) / 2
			$Area2D/CollisionShape2D.scale = $Sprite.scale
		
		elif mousePosition.y <= massSelectionStartingPointY:
			$Sprite.position.y = mousePosition.y
			scalery = massSelectionStartingPointY - mousePosition.y
			$Sprite.scale.y = (scalery/$Sprite.texture.get_height())
			$Area2D/CollisionShape2D.position.y = massSelectionStartingPointY - ($Sprite.scale.y * $Sprite.texture.get_height()) / 2
			$Area2D/CollisionShape2D.scale = $Sprite.scale

func selector():
	if Input.is_action_just_released("select") && $Area2D.get_overlapping_bodies():
		for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit"):
				body.selected = true

