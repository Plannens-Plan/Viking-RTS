extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var GlobalVariable= get_node("/root/GlobalVariables")
onready var units=GlobalVariable.VikingRts.units
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Axemen/Amount.text=String(units.axemen)
	$Spearmen/Amount.text=String(units.spearmen)
	$Archer/Amount.text=String(units.archer)
	$Thrall/Amount.text=String(units.thrall)
	pass
