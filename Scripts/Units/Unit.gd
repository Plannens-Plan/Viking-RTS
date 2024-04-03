extends KinematicBody2D

const GRAVITY = 25
const FLOOR = Vector2(0, -1)

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

#Default unit stats
var moveSpeed = 100
var health = 100
var attackDamage = 25
var attackSpeed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	fall()
	velocity += acceleration * delta
	move_and_slide(velocity, FLOOR)

func fall():
	if is_on_floor() or is_on_ceiling():
		acceleration.y = 0
		velocity.y = 0
	else:
		acceleration.y += GRAVITY
