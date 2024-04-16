extends Camera2D

#cam movement
var holdingLeft = false
var holdingRight = false
var holdingUp = false
var holdingDown = false
var baseCameraSpeed = 125
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var cameraMaxSpeed = 100

#cam zoom
var cameraSpeed = 0
var zoomValue = 1.2
var zoomMax = 3
var zoomMin = 0.2

func _ready():
	pass 

func _physics_process(delta):
	inputChecker()
	inputHandler()
	position += velocity * delta
	velocity += acceleration
	cameraSpeed = baseCameraSpeed * zoom.x
	cameraSlowdown()

func inputChecker():
	if Input.is_action_just_pressed("cam left"):
		holdingLeft = true
	if Input.is_action_just_pressed("cam right"):
		holdingRight = true
	if Input.is_action_just_pressed("cam up"):
		holdingUp = true
	if Input.is_action_just_pressed("cam down"):
		holdingDown = true
	if Input.is_action_just_released("zoom in"):
		if zoom.x < zoomMax:
			zoom *= zoomValue
	if Input.is_action_just_released("zoom out"):
		if zoom. x> zoomMin:
			zoom /= zoomValue

func inputHandler():
	leftHeld()
	rightHeld()
	upHeld()
	downHeld()

func leftHeld():
	if holdingLeft == true:
		acceleration.x = max(acceleration.x - cameraSpeed, -cameraMaxSpeed - cameraSpeed)
	if Input.is_action_just_released("cam left"):
		holdingLeft = false
		return

func rightHeld():
	if holdingRight == true:
		acceleration.x = min(acceleration.x + cameraSpeed, cameraMaxSpeed + cameraSpeed)
	if Input.is_action_just_released("cam right"):
		holdingRight = false
		return

func upHeld():
	if holdingUp == true:
		acceleration.y = max(acceleration.y - cameraSpeed, -cameraMaxSpeed - cameraSpeed)
	if Input.is_action_just_released("cam up"):
		holdingUp = false
		return

func downHeld():
	if holdingDown == true:
		acceleration.y = min(acceleration.y + cameraSpeed, cameraMaxSpeed + cameraSpeed)
	if Input.is_action_just_released("cam down"):
		holdingDown = false
		return

func cameraSlowdown():
	velocity.x = lerp(velocity.x, 0, 0.175)
	velocity.y = lerp(velocity.y, 0, 0.175)
	acceleration.x = lerp(acceleration.x, 0, 0.175)
	acceleration.y = lerp(acceleration.y, 0, 0.175)
