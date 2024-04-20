extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var GlobalVariable= get_node("/root/GlobalVariables")
#onready var Pausemenu = get_node("/root/Pausemenu")

# Called when the node enters the scene tree for the first time.
onready var ifready = false
func _ready():
	ifready=true
func savemapstate():
	#Structures
	print("savemapstate")
	if ifready:
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
		#Units
		var units= GlobalVariable.VikingRts.units
		units.FriendlyAxeman += get_tree().get_nodes_in_group("friendlyAxeman").size()
		units.FriendlyArcher += get_tree().get_nodes_in_group("friendlyArcher").size()
		units.FriendlyThrall += get_tree().get_nodes_in_group("friendlyThrall").size()
		units.FriendlySpearman += get_tree().get_nodes_in_group("friendlySpearman").size()
	#	var FriendlyUnits = scene.get_node("FriendlyUnits")
	#	var units= GlobalVariable.VikingRts.units
	#	for i in FriendlyUnits.get_children():
	#
	#		var unitfile = i.filename 
	#		var shortlength=unitfile.substr(37).split(".tscn")[0]
	#		if not units.has(shortlength):
	#			units[shortlength]=0
	#		units[shortlength]+=1
	#		#print(resloc[resname.name])
		#print("Global")
		#print(GlobalVariable.VikingRts.resourceLocation)
		pass
