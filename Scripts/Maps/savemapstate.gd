extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var GlobalVariable= get_node("/root/GlobalVariables")
onready var Pausemenu = get_node("/root/Pausemenu")

# Called when the node enters the scene tree for the first time.
func _ready():
	Pausemenu.get_node(".").connect("save", self, "savemapstate")
	pass # Replace with function body.


func savemapstate():
	#Structures
	print("savemapstate")
	var Structures = get_tree().current_scene.get_node("Structures/Friendly")
	var beach = GlobalVariable.VikingRts.structureLocation.beach
	for i in Structures.get_children():
		beach.append({
			structure=i.filename,
			position={
				x=i.position.x,
				y=i.position.y
			}
		})
	
	#Resources
	var Res = get_tree().current_scene.get_node("Resources")
	
	#
	pass
