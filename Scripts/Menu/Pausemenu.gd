extends CanvasLayer
onready var savedir="user://Saves/"
onready var GlobalVariable= get_node("/root/GlobalVariables")
onready var Network = get_node("/root/Network")

signal save
func _ready():
	var scene = get_tree().current_scene
	if get_node(".").has_node("Background"):
		if not "Grandmap" in scene.filename && GlobalVariable.Friendly==false:
			$Background/Save.disabled=true
		if "Grandmap" in scene.filename:
			$Background/Grandmap.disabled=true
	pass

func _input(ev):
	#var scene = get_tree().current_scene
	if Input.is_action_just_released("Pause"):
		if get_node(".").has_node("Background"):
			get_tree().paused =!get_tree().paused
			$Background.visible = !$Background.visible 
		


func _on_Continue_pressed():

	if get_node(".").has_node("Background"):
		get_tree().paused =false
		$Background.visible = false
	pass # Replace with function body.


func _on_BackToMenu_pressed():
	saveemit()
	if get_node(".").has_node("Background"):
		get_tree().paused =false
		GlobalVariable.Exiting=true
		TransitionScreen.change_scene("res://Scenes/Menus/Startmenu.tscn")
		BackgroundMusicPlayer.changeSongType("default")

#func save_data(path, data):
#	var file = File.new()
#	file.open(path, File.WRITE)
#
#	file.store_string(to_json(data))
#	file.close()
#
func _on_Save_pressed():
	var units= GlobalVariable.VikingRts.units
	var scene = get_tree().current_scene
	
	saveemit()
	if scene.has_node("FriendlyUnits"):
		units.FriendlyAxeman -= get_tree().get_nodes_in_group("friendlyAxeman").size()
		units.FriendlyArcher -= get_tree().get_nodes_in_group("friendlyArcher").size()
		units.FriendlyThrall -= get_tree().get_nodes_in_group("friendlyThrall").size()
		units.FriendlySpearman -= get_tree().get_nodes_in_group("friendlySpearman").size()
	if get_node(".").has_node("Background"):
		var savename=GlobalVariable.VikingRts.savename
		#save_currentmapstate()
		var data = GlobalVariable.VikingRts
		#save_data(savedir + savename + ".dat", data)
		
		Network.update_save(GlobalVariable.id,savename,to_json(data))

func _on_Button_pressed():
	saveemit()
	if get_node(".").has_node("Background"):
		get_tree().paused =false
		GlobalVariable.Exiting=true
		 
		TransitionScreen.change_scene("res://Scenes/Map/Grandmap.tscn")
		BackgroundMusicPlayer.changeSongType("default")

func saveemit():
	var scene = get_tree().current_scene
	if scene.has_node("savemapstate"):
		scene.get_node("savemapstate").savemapstate()
