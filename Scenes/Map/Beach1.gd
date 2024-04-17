extends Node2D

#var my_group_members = get_tree.get_current.get_nodes_in_group("enemyUnit")
var friendlyUnits
var fcount

var enemyUnits
var ecount


func _ready():
	friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
	fcount = friendlyUnits.size()
	
	enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
	ecount = enemyUnits.size()
	pass # Replace with function body.

func _on_EnemyUnits_tree_exited():
	enemyUnits = get_tree().get_nodes_in_group("enemyUnit")
	ecount = enemyUnits.size()
	pass # Replace with function body.


func _on_FriendlyUnits_tree_exited():
	fcount = friendlyUnits.size()
	friendlyUnits = get_tree().get_nodes_in_group("friendlyUnit")
	pass # Replace with function body.
