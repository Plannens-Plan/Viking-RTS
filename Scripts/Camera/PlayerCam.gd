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
var zoomValue = 1
var zoomMax = 2.5
var zoomMin = 0.5

var scene

#Map
var mapPath
var mapSize

func _ready():
	scene = get_tree().current_scene
	mapPath = scene.get_node("Map")
	mapSize = mapPath.get_size() * mapPath.get_scale()
	limit_left = 0
	limit_right = mapSize.x
	limit_bottom = mapSize.y
	limit_top = 0

func _physics_process(delta):
	inputChecker()
	inputHandler()
	position = get_camera_screen_center()
	position += velocity * delta
	velocity += acceleration
	cameraSpeed = baseCameraSpeed * zoom.x
	cameraSlowdown()
	if zoomValue > zoom.x:
		zoom.x = lerp(zoom.x, zoom.x + zoomValue, 0.03*(zoomValue-zoom.x)+0.01)
		zoom.y = lerp(zoom.y, zoom.x + zoomValue, 0.03*(zoomValue-zoom.y)+0.01)
	if zoomValue < zoom.x:
		zoom.x = lerp(zoom.x, zoom.x - zoomValue, 0.12*(zoom.x-zoomValue)-0.01)
		zoom.y = lerp(zoom.y, zoom.x - zoomValue, 0.12*(zoom.y-zoomValue)-0.01)
	
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
			zoomValue = min(zoomValue + 0.25, zoomMax)
	if Input.is_action_just_released("zoom out"):
		if zoom.x > zoomMin:
			zoomValue = max(zoomValue - 0.25, zoomMin)

func inputHandler():
	leftHeld()
	rightHeld()
	upHeld()
	downHeld()
	self.position.x = clamp(self.position.x , 0, get_tree().current_scene.get_node("Map").get_size().x * get_tree().current_scene.get_node("Map").get_scale().x)
	self.position.y = clamp(self.position.y , 0, get_tree().current_scene.get_node("Map").get_size().y * get_tree().current_scene.get_node("Map").get_scale().y)

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
