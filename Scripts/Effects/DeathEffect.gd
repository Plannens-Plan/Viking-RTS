extends Node2D

var unitSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = unitSprite
	$DeathSound.play()
	pass

func _physics_process(delta):
	if rotation_degrees < 90:
		rotate(0.1)
	if !$DeathSound.playing and rotation_degrees >= 90:
		queue_free()
