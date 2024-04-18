extends "res://Scripts/Units/EnemyUnit.gd"

func _ready():
	if newunit:
		health = 50
		maxHealth = 50
		moveSpeed = 100
		attackDamage = 25
		attackSpeed = 3
		blockChance = 0
		attackSound = load("res://Assets/Sounds/Units/quick_whoosh.mp3")
	updateElements()

func _physics_process(delta):
	pass
