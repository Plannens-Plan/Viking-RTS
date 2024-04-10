extends "res://Scripts/Units/Unit.gd"

# Unit selection
var selected = false
var mouseOver = false

# Unit ordering
var target = false
var targetReachedThreshold = 5.0
var targetPosition = Vector2.ZERO
var direction = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	print(velocity)
	targetLocation(delta)
	if !selected:
		$Sprite.material = null
	else:
		# Give outline
		$Sprite.material = load("res://Assets/Materials/FriendlyUnit.tres")

func _on_Area2D_mouse_entered():
	mouseOver = true

func _on_Area2D_mouse_exited():
	mouseOver = false




func _input(event):
	if event is InputEventMouseButton && event.get_button_index() == 1:
		selected = mouseOver

	if event is InputEventMouseButton && event.get_button_index() == 2 && selected:
		targetPosition = get_global_mouse_position()
		target = true
		direction = (targetPosition - position).normalized()

func targetLocation(delta):
	if target:
		# Calculate acceleration
		acceleration = moveSpeed * direction

		# Update velocity
		velocity += acceleration * delta
		
		velocity.x = lerp(velocity.x, 0, friction)
		velocity.y = lerp(velocity.y, 0, friction)
		
		move_and_slide(velocity)

		# Check if target is reached
		# if position.distance_to(targetPosition) < targetReachedThreshold:
			# acceleration * friction
		if velocity.length_squared() < 1:
			target = false
			velocity = Vector2.ZERO
