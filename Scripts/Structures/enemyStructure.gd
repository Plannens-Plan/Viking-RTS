extends "res://Scripts/Structures/Structure.gd"

onready var GlobalVariable = get_node("/root/GlobalVariables")
onready var resources = GlobalVariable.VikingRts.resources

var killRewardWood = 0
var killRewardStone = 0
var killRewardFood = 0
var killRewardSilver = 0

func _ready():
	outlineColor = Color(1, 0, 0, 1)
	friendly = false
	updateElements()

func _physics_process(delta):
	pass

func die():
	resources.wood += killRewardWood
	resources.stone += killRewardStone
	resources.food += killRewardFood
	resources.silver += killRewardSilver
	.die()
