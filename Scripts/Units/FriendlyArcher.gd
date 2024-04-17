extends "res://Scripts/Units/FriendlyUnit.gd"

func _ready():
	if newunit:
		health = 50
		maxHealth = 50
		moveSpeed = 100
		attackDamage = 25
		attackSpeed = 4
		blockChance = 0
	updateElements()

func _physics_process(delta):
	pass
