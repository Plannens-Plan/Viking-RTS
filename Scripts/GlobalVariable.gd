extends Node

#Brug denne i et script, hvis du skal fetch data
#onready var GlobalVariable= get_node("/root/GlobalVariables")
#GlobalVariable.VikingRts.xxx = yyy eller GlobalVariable.VikingRts["xxx"] = yyy


#lav data her
#export var yyy = xxx

export var VikingRts={
	savename="",
	resources={
		wood=0,
		food=0,
		stone=0,
		silver=0
	}
}

export var Default={
	savename="",
	resources={
		wood=0,
		food=0,
		stone=0,
		silver=0
	}
}
