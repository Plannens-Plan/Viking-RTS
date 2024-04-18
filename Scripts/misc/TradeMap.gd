extends CanvasLayer

var location

var tradeSellAmmount
var tradeBuyAmmount
var tradeSellType
var tradeBuyType
var trades

#Reputation


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


var reputation=0




func _ready():
	pass 


func _input(event):
	if event.is_action_pressed("leftClick") && location != null:
		reputation = dicReputation[location]
		trades = dicTrades[location]
		print(GlobalVariables.VikingRts.resources.get(trades[0]))
		$Panel/RichTextLabel.text = str(trades[0]+reputation , " " , trades[1] , " for " , trades[2]-reputation , " " , trades[3])
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
