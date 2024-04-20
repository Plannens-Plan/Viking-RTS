extends "res://Scripts/Structures/enemyStructure.gd"

func _ready():
	health = 750
	maxHealth = 750
	updateElements()
	killRewardFood = 100
	killRewardSilver = 750
