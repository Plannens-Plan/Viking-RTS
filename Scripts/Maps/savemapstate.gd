extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var GlobalVariable= get_node("/root/GlobalVariables")
#onready var Pausemenu = get_node("/root/Pausemenu")

# Called when the node enters the scene tree for the first time.


func savemapstate():
	#Structures
	print("savemapstate")
	var scene = get_tree().current_scene
	var Structures = scene.get_node("Structures/Friendly")
	var map = ""
	if "Beach1" in scene.filename:
		map = "beach"
	if "Beach2" in scene.filename:
		map = "engvik"
	if "Buns" in scene.filename:
		map = "bun"
	print("map" + map)
	print("scene " + scene.name)
	var beach = GlobalVariable.VikingRts.structureLocation[map]
	for i in Structures.get_children():
		beach.append({
			structure=i.filename,
			position={
				x=i.position.x,
				y=i.position.y
			}
		})
	
	#Resources
	var Res = scene.get_node("Resources")
	for i in Res.get_children():
		var resname= i
		var resloc=GlobalVariable.VikingRts.resourceLocation[map]
		#print(resloc)
		if !resloc.has(resname.name):
			resloc[resname.name]=[]
		#print(resloc[resname.name])
		for j in resname.get_children():
			resloc[resname.name].append({
				position={
					x=j.position.x,
					y=j.position.y
				},
				type=j.filename
			})
		#print(resloc[resname.name])
	#print("Global")
	#print(GlobalVariable.VikingRts.resourceLocation)
	pass
