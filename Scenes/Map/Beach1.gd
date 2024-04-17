extends Node2D

#var my_group_members = get_tree.get_current.get_nodes_in_group("enemyUnit")
var friendlyUnits
var fcount

var enemyUnits
var ecount

onready var winScreen = load("res://Scenes/GUI/WinScreen.tscn").instance()

func _ready():
	
	friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
	fcount = friendlyUnits.size()
	enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
	ecount = enemyUnits.size()
	print(fcount)
	print(ecount)
	pass # Replace with function body.

func _on_EnemyUnits_child_exiting_tree(node):
	enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
	ecount = enemyUnits.size()
	print(ecount)
	if ecount == 1:
		winScreen.remainingTroops = 500
		get_tree().change_scene("res://Scenes/GUI/WinScreen.tscn")
	pass # Replace with function body.


func _on_FriendlyUnits_child_exiting_tree(node):
	fcount = friendlyUnits.size()
	friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
	pass # Replace with function body.
