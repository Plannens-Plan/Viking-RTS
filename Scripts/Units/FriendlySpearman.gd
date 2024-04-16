extends "res://Scripts/Units/FriendlyUnit.gd"

func _ready():
	health = 75
	moveSpeed = 75
	attackDamage = 35
	attackSpeed = 2
	blockChance = 25
	updateElements()

func _physics_process(delta):
	pass
