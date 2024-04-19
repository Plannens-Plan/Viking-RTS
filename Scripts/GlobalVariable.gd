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
		FriendlyAxemen=5,
		FriendlyArcher=2,
		FriendlyThrall=2,
		FriendlySpearmen=10
	},
	structures=[],
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
		FriendlyAxemen=5,
		FriendlyArcher=2,
		FriendlyThrall=2,
		FriendlySpearmen=10
	},
	structures=[],
	progression={
		beach=false,
		engvik=false,
		buns=false
	}
}
