extends KinematicBody2D

# Constants
const GRAVITY = 25
# Defines which direction counts as the floor
const FLOOR = Vector2(0, -1)

# Movement Vectors
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

# Default unit stats
var moveSpeed = 100
var maxSpeed = 300
var friction = 0.05
var health = 100
var attackDamage = 25
var attackSpeed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	fallAndCollide()
	#Accelerate
	velocity += acceleration * delta
	slowOverMaxSpeed()
	# Friction slowdown
	velocity.x = lerp(velocity.x, 0, friction)
	move_and_slide(velocity, FLOOR)

func fallAndCollide():
	if is_on_floor() or is_on_ceiling():
		acceleration.y = 0
		velocity.y = 0
	else:
		acceleration.y += GRAVITY
		
	if is_on_wall():
		acceleration.x = 0
		velocity.x = 0

func slowOverMaxSpeed():
	if velocity.x > maxSpeed:
		velocity.x = maxSpeed
	
	if velocity.x < maxSpeed * -1:
		velocity.x = maxSpeed * -1
	
	if velocity.y > maxSpeed:
		velocity.y = maxSpeed
	
	if velocity.y < maxSpeed * -1:
		velocity.y = maxSpeed * -1
