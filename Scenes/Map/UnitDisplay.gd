extends CanvasLayer

onready var GlobalVariable= get_node("/root/GlobalVariables")

onready var units = GlobalVariable.VikingRts.units

func _process(delta):
	$Spearmen/Amount.text=String(units.FriendlySpearmen)
	$Axemen/Amount.text=String(units.FriendlyAxemen)
	$Archer/Amount.text=String(units.FriendlyArcher)
	$Thrall/Amount.text=String(units.FriendlyThrall)
	pass
