extends Node

#Brug denne i et script, hvis du skal fetch data
#onready var GlobalVariable= get_node("/root/GlobalVariables")
#GlobalVariable.VikingRts.xxx = yyy eller GlobalVariable.VikingRts["xxx"] = yyy
export var RemainingTroops=0
export var Exiting=false
export var Friendly=false
export var id=0
export var saves = {}
#lav data her
#export var yyy = xxx


export var VikingRts={
	savename="",
	resources={
		wood=100,
		food=100,
		stone=100,
		silver=600
	},
	units={
		axemen=5,
		archer=2,
		thrall=2,
		spearmen=10
	},
	structureLocation={
		beach = {structures=[{structureType = "",structurePosition = Vector2()}]},
		engvik = {structures=[{structureType = "",structurePosition = Vector2()}]},
		bun = {structures=[{structureType = "",structurePosition = Vector2()}]},
		},
	progression={
		beach=false,
		engvik=false,
		buns=false
	}
}

export var Default={
	savename="",
	resources={
		wood=100,
		food=100,
		stone=100,
		silver=100
	},
	units={
		axemen=5,
		archer=2,
		thrall=2,
		spearmen=10
	},
	structures=[],
	progression={
		beach=false,
		engvik=false,
		buns=false
	}
}
