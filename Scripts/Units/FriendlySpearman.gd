extends "res://Scripts/Units/FriendlyUnit.gd"

func _ready():
	if newunit:
		health = 75
		maxHealth = 75
		moveSpeed = 75
		attackDamage = 35
		attackSpeed = 1.75
		blockChance = 100
		attackSound = load("res://Assets/Sounds/Units/quick_whoosh.mp3")
	updateElements()

func _physics_process(delta):
	pass
