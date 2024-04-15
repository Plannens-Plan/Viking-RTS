extends Node2D

var unitSprite
var unitSpriteWidth
var unitSpriteHeight

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = unitSprite
	$Sprite.scale.x = unitSpriteWidth
	$Sprite.scale.y = unitSpriteHeight
	$DeathSound.play()
	
	pass

func _physics_process(delta):
	if rotation_degrees < 90:
		rotate(0.05)
	$Sprite.modulate.a -= 0.005
	if !$DeathSound.playing and rotation_degrees >= 90 and $Sprite.modulate.a <= 0:
		queue_free()
