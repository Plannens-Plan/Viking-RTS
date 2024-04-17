extends "res://Scripts/Units/FriendlyUnit.gd"

func _ready():
	if newunit:
		health = 125
		maxHealth = 125
		moveSpeed = 60
		attackDamage = 40
		attackSpeed = 1
		blockChance = 0
	updateElements()

func _physics_process(delta):
	pass
