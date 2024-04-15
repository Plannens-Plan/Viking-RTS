extends KinematicBody2D

# Movement
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

# Default unit stats
var moveSpeed = 100
var maxSpeed = 100
var friction = 0.5
var health = 100
var attackDamage = 25
var attackSpeed = 1.0

onready var death_effect = preload("res://Scenes/Effects/DeathEffect.tscn")
onready var bloodParticle = load("res://Scenes/Particle/BloodParticle.tscn")


func _ready():
	pass

func _physics_process(delta):
	pass

func stopOnCollision():
	if is_on_wall():
		acceleration.x = 0
		velocity.x = 0

func setHealth(newHealth):
	health = newHealth
	var bloodParticleInstance = bloodParticle.instance()
	bloodParticleInstance.emitting=true
	add_child(bloodParticleInstance)
	move_child(bloodParticleInstance,1)
	print(bloodParticleInstance)
	if health <= 0:
		die()

func die():
	var deathEffectInst = death_effect.instance()
	deathEffectInst.unitSprite = $Sprite.texture
	deathEffectInst.unitSpriteWidth = $Sprite.scale.x
	deathEffectInst.unitSpriteHeight = $Sprite.scale.y
	var world = get_tree().current_scene
	world.add_child(deathEffectInst)
	deathEffectInst.global_position = global_position
	queue_free()
