extends Control
onready var savedir="user://Saves/"
onready var GlobalVariable= get_node("/root/GlobalVariables")

func _ready():
	var units= GlobalVariable.VikingRts.units
	if units !=[]:
		var scene=get_tree().get_root().get_child(0)
		if scene.name=="GlobalVariables":
			scene=get_tree().get_root().get_child(1)
		var FriendlyUnits = scene.get_node("FriendlyUnits")
		for i in units:
			FriendlyUnits.add_child(i)
		pass
	pass

func _input(ev):
	if Input.is_key_pressed(KEY_ESCAPE):
		
		get_tree().paused =!get_tree().paused
		$Background.visible = !$Background.visible 
		


func _on_Continue_pressed():
	get_tree().paused =false
	$Background.visible = false
	pass # Replace with function body.


func _on_BackToMenu_pressed():
	get_tree().change_scene("res://Scenes/Menus/Startmenu.tscn")
	get_tree().paused =false
	pass # Replace with function body.


func save_data(path, data):
	var file = File.new()
	file.open(path, File.WRITE)
	
	file.store_string(to_json(data))
	print(data)
	file.close()
	
	
func save_currentmapstate():
	var units= GlobalVariable.VikingRts.units
	#var structures=GlobalVariable.VikingRts.structures
	
	var scene=get_tree().get_root().get_child(0)
	if scene.name=="GlobalVariables":
		scene=get_tree().get_root().get_child(1)
	var FriendlyUnits = scene.get_node("FriendlyUnits")
	
	#var buildings = scene.get_node("Structures")
	for i in FriendlyUnits.get_children():
		print(i)
		
		units.append({
			scene=i.filename,
			pos=i.position
			
		})
	
	print(units)
	
func _on_Save_pressed():
	var savename=GlobalVariable.VikingRts.savename
	save_currentmapstate()
	var data = GlobalVariable.VikingRts
	save_data(savedir + savename + ".dat", data)
	pass # Replace with function body.
