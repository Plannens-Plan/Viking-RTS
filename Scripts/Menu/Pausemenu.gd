extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

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

onready var savedir="user://Saves/"
onready var GlobalVariable= get_node("/root/GlobalVariables")
func save_data(path, data):
	var file = File.new()
	file.open(path, File.WRITE)
	
	file.store_string(to_json(data))
	print(data)
	file.close()
	
func _on_Save_pressed():
	var savename=GlobalVariable.VikingRts.savename
	var data = GlobalVariable.VikingRts
	save_data(savedir + savename + ".dat", data)
	pass # Replace with function body.
