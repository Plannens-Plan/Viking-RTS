extends Node2D

var mouseOver=false


var location

var tradeSellAmmount
var tradeBuyAmmount
var tradeSellType
var tradeBuyType
var trades

var popUpWait = 1

#Reputation
var reputation
var dicReputation = {
	"a":0,
	"b":0,
	"c":0,
	"d":0,
	"e":0
}

var dicTrades = {
	# ammountLocation, typeLocation, ammountPlayer, typePlayer
	"a" : [100,"silver",100,"wood"],
	"b" : [100,"silver",100,"food"],
	"c" : [100,"silver",100,"stone"],
	"d" : [100,"stone",100,"wood"],
	"e" : [100,"food",100,"stone"],
}



func _physics_process(delta):
	if location != null:
		reputation = dicReputation[location]
		trades = dicTrades[location]
		$Panel/TradeText.text = str(trades[0]+reputation , " " , trades[1] , " for " , trades[2]-reputation , " " , trades[3])


func _ready():
	$Panel/Warning/Timer.wait_time = popUpWait
	$Panel/Warning/Timer.one_shot = true
	pass 

func _input(event):
	if event.is_action_pressed("leftClick") && location != null:
		reputation = dicReputation[location]
		trades = dicTrades[location]
		if GlobalVariables.VikingRts.resources.get(trades[3]) >= trades[2]:
			GlobalVariables.VikingRts.resources[trades[1]] += trades[0]
			GlobalVariables.VikingRts.resources[trades[3]] -= trades[2]
			pass
		else: 
			$Panel/Warning.text="you dont have enougt resources"
			$Panel/Warning.show()
			$Panel/Warning/Timer.start()



func _on_TradeMapLocation_mouse_entered():
	location="a"
func _on_TradeMapLocation_mouse_exited():
	location=null

func _on_TradeMapLocation2_mouse_entered():
	location="b"
func _on_TradeMapLocation2_mouse_exited():
	location=null

func _on_TradeMapLocation3_mouse_entered():
	location="c"
func _on_TradeMapLocation3_mouse_exited():
	location=null

func _on_TradeMapLocation4_mouse_entered():
	location="d"
func _on_TradeMapLocation4_mouse_exited():
	location=null

func _on_TradeMapLocation5_mouse_entered():
	location="e"
func _on_TradeMapLocation5_mouse_exited():
		location=null





func _on_Timer_timeout():
	$Panel/Warning.hide()





func _on_Area2D_mouse_entered():
	mouseOver=true
func _on_Area2D_mouse_exited():
	mouseOver=false
