extends Node2D

#var my_group_members = get_tree.get_current.get_nodes_in_group("enemyUnit")
var friendlyUnits
var fcount

var enemyUnits
var ecount

onready var winScreen = preload("res://Scenes/GUI/EndScreen.tscn").instance()
onready var GlobalVariable= get_node("/root/GlobalVariables")

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
	else:
		friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
		fcount = friendlyUnits.size()
		enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
		ecount = enemyUnits.size()

func _on_EnemyUnits_child_exiting_tree(node):
	enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
	ecount = enemyUnits.size()
	
	if ecount == 1 && GlobalVariable.Exiting ==false && GlobalVariable.VikingRts.progression.beach==false:
		GlobalVariable.RemainingTroops = fcount
		var units= GlobalVariable.VikingRts.units
		var scene = get_tree().current_scene
		
		var FriendlyUnits = scene.get_node("FriendlyUnits")
		for i in FriendlyUnits.get_children():
			units.append({
			scene=i.filename,
		})
		GlobalVariable.VikingRts.progression.beach=true
		
		TransitionScreen.change_scene("res://Scenes/GUI/EndScreen.tscn")
	pass # Replace with function body.


func _on_FriendlyUnits_child_exiting_tree(node):

	
	friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
	fcount = friendlyUnits.size()

	if fcount == 1 && GlobalVariable.Exiting ==false && GlobalVariable.VikingRts.progression.beach==false:
		GlobalVariable.RemainingTroops = fcount
		TransitionScreen.change_scene("res://Scenes/GUI/EndScreen.tscn")
	pass # Replace with function body.
