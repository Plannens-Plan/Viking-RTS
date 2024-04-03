extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _input(event):
	if event.is_action_pressed("cam left"):
		print("balls")
		position.x=position.x-20
	
	if event.is_action_pressed("cam right"):
		position.x=position.x+20
		pass
	
	if event.is_action_pressed("cam up"):
		position.y=position.y-20
		pass
	
	if event.is_action_pressed("cam down"):
		position.y=position.y+20
		pass
	
	pass

func _physics_process(delta):
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
