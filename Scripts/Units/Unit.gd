extends KinematicBody2D

# Constants

# Movement
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

# Default unit stats
var moveSpeed = 100
var maxSpeed = 100
var friction = 0.01
var health = 100
var attackDamage = 25
var attackSpeed = 1

func _ready():
	pass

func _physics_process(delta):
	pass

func stopOnCollision():
	if is_on_wall():
		acceleration.x = 0
		velocity.x = 0
