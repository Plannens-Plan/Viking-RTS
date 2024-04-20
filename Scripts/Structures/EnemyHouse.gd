extends "res://Scripts/Structures/enemyStructure.gd"

func _ready():
	health = 400
	maxHealth = 400
	updateElements()
	killRewardWood = 100
	killRewardStone = 100
	killRewardFood = 100
	killRewardSilver = 100
