extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#set_process_input(true) 
	pass # Replace with function body.

func _input(ev):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().paused =true
		$Background.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Continue_pressed():
	get_tree().paused =false
	$Background.visible = false
	pass # Replace with function body.
