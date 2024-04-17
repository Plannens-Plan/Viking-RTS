extends "res://Scripts/Units/EnemyUnit.gd"

func _ready():
	if newunit:
		health = 75
		maxHealth = 75
		moveSpeed = 75
		attackDamage = 35
		attackSpeed = 1.75
		blockChance = 25
	updateElements()

func _physics_process(delta):
	pass
