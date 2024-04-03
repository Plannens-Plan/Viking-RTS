extends KinematicBody2D

const gravity = 25

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	velocity.y += gravity
	move_and_slide(velocity)
