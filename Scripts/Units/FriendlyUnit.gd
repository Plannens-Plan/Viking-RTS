extends "res://Scripts/Units/Unit.gd"

# Unit selection
var selected = false
var mouseOver = false

# Unit ordering
var target = false
var slowDown = false
var targetReachedThreshold = 15.0
var direction = Vector2.ZERO
var targetPosition = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	print(health)
	targetLocation(delta)
	slowAccel()
	if !selected:
		$Sprite.material = null
	else:
		# Give outline
		$Sprite.material = load("res://Assets/Materials/Outline.tres")
	print(acceleration.length() )

func _on_Area2D_mouse_entered():
	mouseOver = true

func _on_Area2D_mouse_exited():
	mouseOver = false




func _input(event):
	if event is InputEventMouseButton && event.get_button_index() == 1:
		selected = mouseOver

	if event is InputEventMouseButton && event.get_button_index() == 2 && selected:
		slowDown = false
		targetPosition = get_global_mouse_position()
		direction = (targetPosition - position).normalized()
		acceleration = moveSpeed * direction

func targetLocation(delta):
		velocity += acceleration
		
		velocity.x = lerp(velocity.x, 0, friction)
		velocity.y = lerp(velocity.y, 0, friction)
		
		move_and_slide(velocity)
		if targetPosition != null && position.distance_to(targetPosition) < targetReachedThreshold:
			slowDown = true
			
func slowAccel():
	if (slowDown):
		acceleration *= 0.9
