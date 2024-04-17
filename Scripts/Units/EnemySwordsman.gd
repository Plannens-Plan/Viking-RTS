extends "res://Scripts/Units/EnemyUnit.gd"

func _ready():
	if newunit:
		health = 100
		maxHealth = 100
		moveSpeed = 90
		attackDamage = 25
		attackSpeed = 1
		blockChance = 40
		attackSound = load("res://Assets/Sounds/Units/whoosh_light.mp3")
	updateElements()

func _physics_process(delta):
	pass
