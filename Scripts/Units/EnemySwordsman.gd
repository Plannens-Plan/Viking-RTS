extends "res://Scripts/Units/EnemyUnit.gd"

func _ready():
	if newunit:
		health = 100
		maxHealth = 100
		moveSpeed = 90
		attackDamage = 25
		attackSpeed = 1
		blockChance = 40
	updateElements()

func _physics_process(delta):
	pass
