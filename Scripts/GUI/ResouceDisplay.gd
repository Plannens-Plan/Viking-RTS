extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var GlobalVariable= get_node("/root/GlobalVariables")

onready var resource=GlobalVariable.VikingRts.resources
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Food/Amount.text=String(resource.food)
	$Silver/Amount.text=String(resource.silver)
	$Stone/Amount.text=String(resource.stone)
	$Wood/Amount.text=String(resource.wood)
	
	pass
