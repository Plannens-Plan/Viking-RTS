extends Node2D

#var my_group_members = get_tree.get_current.get_nodes_in_group("enemyUnit")
var friendlyUnits
var fcount

var enemyUnits
var ecount

onready var winScreen = preload("res://Scenes/GUI/EndScreen.tscn").instance()
onready var GlobalVariable= get_node("/root/GlobalVariables")
#onready var Pausemenu = get_node("/root/Pausemenu")

func _ready():
	friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
	fcount = friendlyUnits.size()
	enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
	ecount = enemyUnits.size()
	if GlobalVariable.VikingRts.progression.beach:
		GlobalVariable.Friendly=true
		var eu = get_tree().current_scene.get_node("EnemyUnits")
		var fu = get_tree().current_scene.get_node("FriendlyUnits")
		for n in eu.get_children():
			eu.remove_child(n)
		for n in fu.get_children():
			fu.remove_child(n)
		var Structures = get_tree().current_scene.get_node("Structures/Friendly")
		var beach = GlobalVariable.VikingRts.structureLocation.beach
		for i in beach:
			print(i)
			var struct = load(i.structure).instance()
			struct.position.x =i.position.x
			struct.position.y =i.position.y
			Structures.add_child(struct)
			
		BackgroundMusicPlayer.changeSongType("default")
	else:
		friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
		fcount = friendlyUnits.size()
		enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
		ecount = enemyUnits.size()
		BackgroundMusicPlayer.changeSongType("combat")
		
#func savemapstate():
#	#Structures
#	var Structures = get_tree().current_scene.get_node("Structures/Friendly")
#	var beach = GlobalVariable.VikingRts.structureLocation.beach
#	for i in Structures.get_children():
#		beach.append({
#			structure=i.filename,
#			position=i.position
#		})
#
#	#Resources
#	var Res = get_tree().current_scene.get_node("Resources")
#
#	#
#	pass

func _on_EnemyUnits_child_exiting_tree(node):
	enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
	ecount = enemyUnits.size()
	
	if ecount == 1 && GlobalVariable.Exiting ==false && GlobalVariable.VikingRts.progression.beach==false:
		GlobalVariable.RemainingTroops = fcount
		var units= GlobalVariable.VikingRts.units
		var scene = get_tree().current_scene
		
		var FriendlyUnits = scene.get_node("FriendlyUnits")
		for i in FriendlyUnits.get_children():
			var unitfile = i.filename 
			var shortlength=unitfile.substr(37).split(".tscn")[0]
			if not units.has(shortlength):
				units[shortlength]=0
			units[shortlength]+=1
		GlobalVariable.VikingRts.progression.beach=true
		
		TransitionScreen.change_scene("res://Scenes/GUI/EndScreen.tscn")

func _on_FriendlyUnits_child_exiting_tree(node):
	friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
	fcount = friendlyUnits.size()

	if fcount == 1 && GlobalVariable.Exiting ==false && GlobalVariable.VikingRts.progression.beach==false:
		GlobalVariable.RemainingTroops = fcount
		TransitionScreen.change_scene("res://Scenes/GUI/EndScreen.tscn")
