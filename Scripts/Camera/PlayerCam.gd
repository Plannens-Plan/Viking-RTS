extends Camera2D

var holdingLeft=false
var holdingRight=false
var holdingUp=false
var holdingDown=false
var cameraSpeed=20

func _ready():
	pass 
	

func _input(event):
	if event.is_action_pressed("cam right"):
		position.x=position.x+20

	if event.is_action_pressed("cam up"):
		position.y=position.y-20

	if event.is_action_pressed("cam down"):
		position.y=position.y+20
	pass

func _physics_process(delta):
	inputChecker()
	inputHandler()
	pass

func inputChecker():
	if Input.is_action_just_pressed("cam left"):
		holdingLeft=true
	if Input.is_action_just_pressed("cam right"):
		holdingRight=true
	if Input.is_action_just_pressed("cam up"):
		holdingUp=true
	if Input.is_action_just_pressed("cam down"):
		holdingDown=true

func inputHandler():
	leftHeld()
	rightHeld()
	upHeld()
	downHeld()


func leftHeld():
	if holdingLeft==true:
		position.x=position.x-cameraSpeed
	if Input.is_action_just_released("cam left"):
		holdingLeft=false
		return


func rightHeld():
	if holdingRight==true:
		position.x=position.x+cameraSpeed
	if Input.is_action_just_released("cam right"):
		holdingRight=false
		return

func upHeld():
	if holdingUp==true:
		position.y=position.y-cameraSpeed
	if Input.is_action_just_released("cam up"):
		holdingUp=false
		return

func downHeld():
	if holdingDown==true:
		position.y=position.y+cameraSpeed
	if Input.is_action_just_released("cam down"):
		holdingDown=false
		return
