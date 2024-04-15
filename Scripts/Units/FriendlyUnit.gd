extends "res://Scripts/Units/Unit.gd"

onready var attackArea = $AttackArea
onready var attackTimer = $AttackTimer

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
	attackTimer.wait_time = attackSpeed
	attackTimer.one_shot=true
	attackTimer.start()
	pass
func _ready():
	set_target_location(position)

func Attack():
	if attackArea.get_overlapping_bodies().size()>0 && attackTimer.time_left <= 0:
		for body in attackArea.get_overlapping_bodies():
			if body.is_in_group("friendlyUnit"):
				body.setHealth(body.health - attackDamage)
				attackTimer.start()
				return

func _physics_process(delta):
	if !selected:
		$Sprite.material = null
	else:
		# Give outline
		$Sprite.material = load("res://Assets/Materials/Outline.tres")
	
func _on_Area2D_mouse_entered():
	mouseOver = true

func _on_Area2D_mouse_exited():
	mouseOver = false

func _input(event):
	if event is InputEventMouseButton && event.get_button_index() == 1:
		selected = mouseOver

	if event is InputEventMouseButton && event.get_button_index() == 2 && selected:
		set_target_location(get_global_mouse_position())

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


func _on_NavigationAgent2D_target_reached():
	pass # Replace with function body.
