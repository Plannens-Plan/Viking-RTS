extends Node2D
var massSelectionStartingPointX=null
var massSelectionStartingPointY=null
var held=false
var scalerx=null
var scalery=null

func _ready():
	$Bruh.hide()

func _physics_process(delta):
	inputter()
	checker()

func inputter():
	if Input.is_action_just_pressed("select"):
		held = true
		$Bruh.show()
	if Input.is_action_just_released("select"):
		held = false
		massSelectionStartingPointX = null
		massSelectionStartingPointY = null
		$Bruh.hide()
		selector()

func checker():
	if held==true:
		if massSelectionStartingPointX == null && massSelectionStartingPointY == null:
			massSelectionStartingPointX = get_global_mouse_position().x as float
			massSelectionStartingPointY = get_global_mouse_position().y as float
		
		if get_global_mouse_position().x > massSelectionStartingPointX:
			$Bruh.position.x = massSelectionStartingPointX
			scalerx = get_global_mouse_position().x - massSelectionStartingPointX
			$Bruh.scale.x = (scalerx / $Bruh.texture.get_width())
			$Area2D/CollisionShape2D.position.x = massSelectionStartingPointX + ($Bruh.scale.x * $Bruh.texture.get_width()) / 2
			$Area2D/CollisionShape2D.scale=$Bruh.scale
		
		elif get_global_mouse_position().x <= massSelectionStartingPointX:
			$Bruh.position.x = get_global_mouse_position().x
			scalerx = massSelectionStartingPointX - get_global_mouse_position().x
			$Bruh.scale.x = (scalerx / $Bruh.texture.get_width())
			$Area2D/CollisionShape2D.position.x = massSelectionStartingPointX - ($Bruh.scale.x * $Bruh.texture.get_width()) / 2
			$Area2D/CollisionShape2D.scale=$Bruh.scale
		
		if get_global_mouse_position().y > massSelectionStartingPointY:
			$Bruh.position.y = massSelectionStartingPointY
			scalery = get_global_mouse_position().y - massSelectionStartingPointY
			$Bruh.scale.y = (scalery / $Bruh.texture.get_height())
			$Area2D/CollisionShape2D.position.y = massSelectionStartingPointY + ($Bruh.scale.y * $Bruh.texture.get_height()) / 2
			$Area2D/CollisionShape2D.scale=$Bruh.scale
		
		elif get_global_mouse_position().y <= massSelectionStartingPointY:
			$Bruh.position.y = get_global_mouse_position().y
			scalery = massSelectionStartingPointY - get_global_mouse_position().y
			$Bruh.scale.y = (scalery/$Bruh.texture.get_height())
			$Area2D/CollisionShape2D.position.y = massSelectionStartingPointY - ($Bruh.scale.y * $Bruh.texture.get_height()) / 2
			$Area2D/CollisionShape2D.scale=$Bruh.scale


func selector():
	if Input.is_action_just_released("select") && $Area2D.get_overlapping_bodies():
		for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit"):
				body.selected = true

