extends Node2D

#var my_group_members = get_tree.get_current.get_nodes_in_group("enemyUnit")
var friendlyUnits
var fcount

var enemyBuildings
var enemyUnits
var ecount
var ifready = false

onready var winScreen = preload("res://Scenes/GUI/EndScreen.tscn").instance()
onready var GlobalVariable= get_node("/root/GlobalVariables")
#onready var Pausemenu = get_node("/root/Pausemenu")

func _ready():
	friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
	fcount = friendlyUnits.size()
	enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
	enemyBuildings = get_tree().get_nodes_in_group("enemyBuilding")
	ecount = enemyUnits.size()
	if GlobalVariable.VikingRts.progression.get(str(self.name)):
		GlobalVariable.Friendly=true
		var eu = get_tree().current_scene.get_node("EnemyUnits")
		var fu = get_tree().current_scene.get_node("FriendlyUnits")
		for n in eu.get_children():
			eu.remove_child(n)
		for n in fu.get_children():
			fu.remove_child(n)
		var es = get_tree().current_scene.get_node("Structures/Enemy")
		for n in es.get_children():
			es.remove_child(n)
		var Structures = get_tree().current_scene.get_node("Structures/Friendly")
		var location = GlobalVariable.VikingRts.structureLocation.get(str(self.name))
		for i in location:
			var struct = load(i.structure).instance()
			struct.position.x =i.position.x
			struct.position.y =i.position.y
			Structures.add_child(struct)
		var res = get_tree().current_scene.get_node("Resources")
		for i in res.get_children():
			for j in i.get_children():
				i.remove_child(j)
		var savedres = GlobalVariable.VikingRts.resourceLocation.get(str(self.name))
		for i in savedres:
			var type = res.get_node(i)
			for j in savedres[i]:
				var struct = load(j.type).instance()
				struct.position.x =j.position.x
				struct.position.y =j.position.y
				type.add_child(struct)
		BackgroundMusicPlayer.changeSongType("default")
	else:
		friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
		fcount = friendlyUnits.size()
		enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
		ecount = enemyUnits.size()
		BackgroundMusicPlayer.changeSongType("combat")
	ifready=true
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

func _on_Enemy_child_exiting_tree(node):
	checkWin()

func _on_EnemyUnits_child_exiting_tree(node):
	checkWin()

func _on_FriendlyUnits_child_exiting_tree(node):
	friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
	fcount = friendlyUnits.size()

	if fcount == 1 && GlobalVariable.Exiting ==false && GlobalVariable.VikingRts.progression.get(str(self.name))==false:
		GlobalVariable.RemainingTroops = fcount
		TransitionScreen.change_scene("res://Scenes/GUI/EndScreen.tscn")
func saveemit():
	var scene = get_tree().current_scene
	if scene.has_node("savemapstate"):
		scene.get_node("savemapstate").savemapstate()		

func checkWin():
	enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
	enemyBuildings = get_tree().get_nodes_in_group("enemyBuilding")
	ecount = enemyUnits.size() + enemyBuildings.size()
	if ecount == 1 && GlobalVariable.Exiting ==false && GlobalVariable.VikingRts.progression.get(str(self.name))==false:
		GlobalVariable.RemainingTroops = fcount
		var units= GlobalVariable.VikingRts.units
#		var scene = get_tree().current_scene
#		var FriendlyUnits = scene.get_node("FriendlyUnits")
#		for i in FriendlyUnits.get_children():
#			var unitfile = i.filename 
#			var shortlength=unitfile.substr(37).split(".tscn")[0]
#			if not units.has(shortlength):
#				units[shortlength]=0
#			units[shortlength]+=1
		GlobalVariable.VikingRts.progression[str(self.name)] = true
		if ifready:
			saveemit()
		TransitionScreen.change_scene("res://Scenes/GUI/EndScreen.tscn")



