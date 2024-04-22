extends "res://Scripts/Units/Unit.gd"

var delay_timer
var targetX
var targetY

func _ready():
	delay_timer = $PanicTimer
	delay_timer.one_shot = true
	delay_timer.start()
	setRandomTexture()
	targetX = position.x
	targetY = position.y
 
func _physics_process(delta):
	TargetFriendly()

func TargetFriendly():
	if $DetectArea.get_overlapping_bodies().size() > 0:
		for body in $DetectArea.get_overlapping_bodies():
			if body.is_in_group("enemyUnit") or body.is_in_group("friendlyUnit"):
				if delay_timer.time_left <= 0:
					targetX = position.x + get_random_number()
					targetY = position.y + get_random_number()
					set_target_location(Vector2(targetX, targetY))
					delay_timer.start()

func get_random_number():
	var is_negative = rng.randi() % 2 == 0
	var maxRange = 120
	var minRange = 60
	
	if is_negative:
		return rng.randi_range(-maxRange, -minRange)
	else:
		return rng.randi_range(minRange, maxRange)

func setRandomTexture():
	rng.randomize()
	var textureNumber = rng.randi_range(1, 2)
	match textureNumber:
		1:
			$Sprite.texture = load("res://Assets/Images/Units/monk.png")
		2:
			$Sprite.texture = load("res://Assets/Images/Units/monk_staffless.png")
