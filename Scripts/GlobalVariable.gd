extends Node

#Brug denne i et script, hvis du skal fetch data
#onready var GlobalVariable= get_node("/root/GlobalVariables")
#GlobalVariable.VikingRts.xxx = yyy eller GlobalVariable.VikingRts["xxx"] = yyy
export var RemainingTroops=0
export var Exiting=false
export var Friendly=false
export var id=0
export var saves = []
#lav data her
#export var yyy = xxx
signal save
func emitsignal():
	emit_signal("save")

export var VikingRts={
	savename="",
	resources={
		wood=500,
		food=500,
		stone=500,
		silver=500
	},
	units={
		FriendlyAxeman=5,
		FriendlyArcher=2,
		FriendlyThrall=2,
		FriendlySpearman=10
	},
	structureLocation={
		beach = [],
		engvik = [],
		bun = [],
		},
	resourceLocation={
		beach = {},
		engvik = {},
		bun = {},
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
		wood=500,
		food=500,
		stone=500,
		silver=500
	},
	units={
		FriendlyAxeman=5,
		FriendlyArcher=2,
		FriendlyThrall=2,
		FriendlySpearman=10
	},
	structureLocation={
		beach = [],
		engvik = [],
		bun = [],
		},
	resourceLocation={
		beach = {},
		engvik = {},
		bun = {},
	},
	progression={
		beach=false,
		engvik=false,
		buns=false
	}
}

func defaultsave():
	print("Default save load")
	#VikingRts={}
	#VikingRts=Default
	var dict = Default
	for key in dict:
		if VikingRts.has(key):
			if typeof(VikingRts[key]) ==18:
				var dict2=dict[key]
				for key2 in dict2:
					VikingRts[key][key2] = dict2[key2]

			else:
				VikingRts[key]=dict[key]
