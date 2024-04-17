extends Node2D
var massSelectionStartingPointX=null
var massSelectionStartingPointY=null
var held=false
var scalerx=null
var scalery=null
var selectionStopper = false

func _ready():
	$Sprite.hide()

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
	if held == true:
		if massSelectionStartingPointX == null && massSelectionStartingPointY == null:
			massSelectionStartingPointX = get_global_mouse_position().x as float
			massSelectionStartingPointY = get_global_mouse_position().y as float
		
		if get_global_mouse_position().x > massSelectionStartingPointX:
			$Sprite.position.x = massSelectionStartingPointX
			scalerx = get_global_mouse_position().x - massSelectionStartingPointX
			$Sprite.scale.x = (scalerx / $Sprite.texture.get_width())
			$Area2D/CollisionShape2D.position.x = massSelectionStartingPointX + ($Sprite.scale.x * $Sprite.texture.get_width()) / 2
			$Area2D/CollisionShape2D.scale = $Sprite.scale
		
		elif get_global_mouse_position().x <= massSelectionStartingPointX:
			$Sprite.position.x = get_global_mouse_position().x
			scalerx = massSelectionStartingPointX - get_global_mouse_position().x
			$Sprite.scale.x = (scalerx / $Sprite.texture.get_width())
			$Area2D/CollisionShape2D.position.x = massSelectionStartingPointX - ($Sprite.scale.x * $Sprite.texture.get_width()) / 2
			$Area2D/CollisionShape2D.scale=$Sprite.scale
		
		if get_global_mouse_position().y > massSelectionStartingPointY:
			$Sprite.position.y = massSelectionStartingPointY
			scalery = get_global_mouse_position().y - massSelectionStartingPointY
			$Sprite.scale.y = (scalery / $Sprite.texture.get_height())
			$Area2D/CollisionShape2D.position.y = massSelectionStartingPointY + ($Sprite.scale.y * $Sprite.texture.get_height()) / 2
			$Area2D/CollisionShape2D.scale = $Sprite.scale
		
		elif get_global_mouse_position().y <= massSelectionStartingPointY:
			$Sprite.position.y = get_global_mouse_position().y
			scalery = massSelectionStartingPointY - get_global_mouse_position().y
			$Sprite.scale.y = (scalery/$Sprite.texture.get_height())
			$Area2D/CollisionShape2D.position.y = massSelectionStartingPointY - ($Sprite.scale.y * $Sprite.texture.get_height()) / 2
			$Area2D/CollisionShape2D.scale = $Sprite.scale

func selector():
	if Input.is_action_just_released("select") && $Area2D.get_overlapping_bodies():
		for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit"):
				body.selected = true

