extends Control

onready var GlobalVariable = get_node("/root/GlobalVariables")

func _ready():
	if GlobalVariable.Friendly:
		$BuildPanelCanvas.show()
