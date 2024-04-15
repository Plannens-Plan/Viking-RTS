extends KinematicBody2D

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
	setHealth(health - 1)
	pass

func stopOnCollision():
	if is_on_wall():
		acceleration.x = 0
		velocity.x = 0

func setHealth(newHealth):
	health = newHealth
	if health <= 0:
		die()

func die():
	$DeathSound.play()
	while rotation_degrees < 90:
		rotate(1)
	queue_free()
