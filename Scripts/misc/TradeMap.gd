extends CanvasLayer

var location

var tradeSellAmmount
var tradeBuyAmmount
var tradeSellType
var tradeBuyType

#Reputation


var dicReputation = {
"a":0,
"b":0,
"c":0,
"d":0,
"e":0
}


var reputation=0




func _ready():
	pass 


func _input(event):
	if event.is_action_pressed("leftClick"):
		reputation = dicReputation[location]
		tradeBuyAmmount = 100/(reputation+1)
		tradeBuyType = "Wood"
		tradeSellAmmount = 100/(reputation+1)
		tradeSellType = "Stone"
		print(tradeSellAmmount)
		dicReputation[location] += 1



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
