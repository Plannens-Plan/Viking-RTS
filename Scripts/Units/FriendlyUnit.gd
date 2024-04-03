extends "res://Scripts/Units/Unit.gd"
var selected = false
var mouseOver = false
var targetLocationX = null
var targetLocationY = null
var target = false
var targetPosition = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	targetLocation()
#	if Input.is_action_just_pressed("right_click"):
#		if(get_global_mouse_position().x < position.x):
#			acceleration.x -= moveSpeed

func _on_Area2D_mouse_entered():
	mouseOver=true

func _on_Area2D_mouse_exited():
	mouseOver=false

func _input(event):
	if event is InputEventMouseButton && event.get_button_index()==1 && mouseOver==true:
		selected=true
		
	if event is InputEventMouseButton && event.get_button_index()==1 && mouseOver==false:
		selected=false
	if event is InputEventMouseButton && event.get_button_index()==2 && selected==true:
		if targetLocationX!=null:
			targetLocationX=get_global_mouse_position().x as float
			targetLocationY=get_global_mouse_position().y as float
			target=true
			if position.x>targetLocationX&&targetPosition==1:
				print("")
				pass
			elif position.x<targetLocationX&&targetPosition==2:
				print("no")
				pass
			else:
				print ("bruh")
				targetPosition=0
				acceleration.x=0
				velocity.x=0
		else:
			targetLocationX=get_global_mouse_position().x as float
			targetLocationY=get_global_mouse_position().y as float
			target=true
		#selected=false


func targetLocation():
	if target==true:
		if position.x!=targetLocationX:
			if position.x>targetLocationX:
				if targetPosition==0:
					targetPosition=1
				acceleration.x -= moveSpeed
			
			if position.x<targetLocationX:
				if targetPosition==0:
					targetPosition=2
				acceleration.x += moveSpeed
			
			if position.x>targetLocationX&&targetPosition==2:
				acceleration.x=0
				velocity.x=0
				position.x=targetLocationX
				target=false
				targetPosition=0
				targetLocationX=null
				targetLocationY=null
				return
			
			if position.x<targetLocationX&&targetPosition==1:
				acceleration.x=0
				velocity.x=0
				position.x=targetLocationX
				target=false
				targetPosition=0
				targetLocationX=null
				targetLocationY=null
				return
