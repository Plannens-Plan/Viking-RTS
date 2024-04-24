extends "res://Scripts/Units/FriendlyUnit.gd"

func _ready():
	finalUnit = true
	if newunit:
		health = 125
		maxHealth = 125
		moveSpeed = 90
		attackDamage = 40
		attackSpeed = 1
		blockChance = 0
		attackSound = load("res://Assets/Sounds/Units/whoosh_heavy.mp3")
	updateElements()

func _physics_process(delta):
	pass
