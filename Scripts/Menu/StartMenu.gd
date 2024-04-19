extends Node

onready var GlobalVariable= get_node("/root/GlobalVariables")
onready var input_text : LineEdit  = get_node("CanvasLayer/Newgame/Savenametext")
onready var dropmenu : MenuButton  = get_node("CanvasLayer/Loadgame/PanelContainer/Savefiles")

onready var dir = Directory.new()
onready var savedir="user://Saves/"
onready var startgamepath="res://Scenes/Map/Grandmap.tscn"

func _ready():
	GlobalVariable.Exiting=false
	
	if dropmenu.get_popup().items.size()>0:
		while dropmenu.get_popup().items.size()>0:
			dropmenu.get_popup().remove_item(0)
	if !dir.dir_exists(savedir):
		dir.make_dir(savedir)
	dir.open(savedir)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		var id=dropmenu.get_popup().items.size()
		var filename=file.substr(0,file.length()-4)
		if(filename==""):
			continue
		dropmenu.get_popup().add_item(filename, id)
		
	dir.list_dir_end()
	
	dropmenu.get_popup().connect("id_pressed", self, "_on_MenuButton_pressed")

func load_data(path):
	var file = File.new()
	var content
	file.open(path,File.READ)
	content= file.get_as_text()
	file.close()
	return parse_json(content)

#Menu buttons
func _on_quit_game_pressed():
	get_tree().quit()

func _on_Load_game_pressed():
	$CanvasLayer/MenuButtons.hide()
	$CanvasLayer/Loadgame.show()

func _on_Newgame_pressed():
	$CanvasLayer/MenuButtons.hide()
	$CanvasLayer/Newgame.show()



#New game functions
func _on_Backbutton_pressed():
	$CanvasLayer/MenuButtons.show()
	$CanvasLayer/Newgame.hide()

func _on_Start_game_pressed():
	var file = File.new()
	if input_text.text=="":
		$CanvasLayer/Newgame/Warning.show()
		return
	var disallowedcharacters=[
		"/",
		";",
		":",
		"<",
		">",
		"*",
		"?",
		"|",
		"\\",
		'"',
		"'"
	]
	for i in disallowedcharacters:
		if i in input_text.text:
			$CanvasLayer/Newgame/Warning3.show()
			return
	if file.file_exists(savedir + input_text.text + ".dat"):
		$CanvasLayer/Newgame/Warning2.show()
		return
	
	GlobalVariable.VikingRts=GlobalVariable.Default
	GlobalVariable.VikingRts.savename=input_text.text
	get_tree().change_scene("res://Scenes/Map/Beach1.tscn")
	#TransitionScreen.change_scene(startgamepath, 'intro').

func _on_Savenametext_text_changed(new_text):
	if $CanvasLayer/Newgame/Warning.visible:
		$CanvasLayer/Newgame/Warning.hide()
	if $CanvasLayer/Newgame/Warning2.visible:
		$CanvasLayer/Newgame/Warning2.hide()
	if $CanvasLayer/Newgame/Warning3.visible:
		$CanvasLayer/Newgame/Warning3.hide()

#Load game functions
func _on_Backbutton_pressed2():
	$CanvasLayer/MenuButtons.show()
	$CanvasLayer/Loadgame.hide()

func _on_MenuButton_pressed(id):
	dropmenu.text=dropmenu.get_popup().get_item_text(id/10)
	
func _on_Load_savegame_pressed():
	var file = File.new()
	if not file.file_exists(savedir + dropmenu.text + ".dat"):
		$CanvasLayer/Loadgame/Warning.show()
		return
	
	var dict=load_data(savedir + dropmenu.text + ".dat")

	for key in dict:
		if GlobalVariable.VikingRts.has(key):
			if typeof(GlobalVariable.VikingRts[key]) ==18:
				var dict2=dict[key]
				for key2 in dict2:
					GlobalVariable.VikingRts[key][key2] = dict2[key2]

			else:
				GlobalVariable.VikingRts[key]=dict[key]
	TransitionScreen.change_scene(startgamepath)
	



