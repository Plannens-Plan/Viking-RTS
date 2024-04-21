extends Control


onready var GlobalVariable= get_node("/root/GlobalVariables")
onready var remainingTroops = GlobalVariable.RemainingTroops

func _ready():
	print (remainingTroops)
	
	if remainingTroops > 1:
		$Label.text = "You won wow. \nYour remaining troops: " + str(remainingTroops-1)
	else:
		$Button.hide()
		$Label.text = "You lost wow. \nYour remaining troops is now GGS: " + str(remainingTroops-1)
		var timer
		timer = Timer.new()
		timer.connect("timeout", self, "_on_Timer_timeout")
		timer.wait_time = 5
		add_child(timer)
		timer.start()

func _on_Button_pressed():
	TransitionScreen.change_scene("res://Scenes/Map/Grandmap.tscn")
	BackgroundMusicPlayer.changeSongType("default")


func _on_Timer_timeout():
	TransitionScreen.change_scene("res://Scenes/Menus/Startmenu.tscn")
	BackgroundMusicPlayer.changeSongType("default")
