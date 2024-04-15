extends Camera2D

#cam movement
var holdingLeft = false
var holdingRight = false
var holdingUp = false
var holdingDown = false
var baseCameraSpeed = 20

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
	cameraSpeed=baseCameraSpeed*zoom.x

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
		if zoom.x<zoomMax:
			zoom*=zoomValue
	if Input.is_action_just_released("zoom out"):
		if zoom.x>zoomMin:
			zoom/=zoomValue

func inputHandler():
	leftHeld()
	rightHeld()
	upHeld()
	downHeld()

func leftHeld():
	if holdingLeft == true:
		position.x = position.x - cameraSpeed
	if Input.is_action_just_released("cam left"):
		holdingLeft = false
		return

func rightHeld():
	if holdingRight == true:
		position.x = position.x + cameraSpeed
	if Input.is_action_just_released("cam right"):
		holdingRight = false
		return

func upHeld():
	if holdingUp == true:
		position.y = position.y - cameraSpeed
	if Input.is_action_just_released("cam up"):
		holdingUp = false
		return

func downHeld():
	if holdingDown == true:
		position.y = position.y + cameraSpeed
	if Input.is_action_just_released("cam down"):
		holdingDown = false
		return
