extends Node2D

onready var GlobalVariable= get_node("/root/GlobalVariables")
onready var input_text : LineEdit  = get_node("Panel/Input")

onready var dropmenu : MenuButton  = get_node("Panel/Savefiles")
onready var dir = Directory.new()
onready var savedir="user://Saves/"

func reloadsaves():
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

func _ready():
	reloadsaves()
	dropmenu.get_popup().connect("id_pressed", self, "_on_MenuButton_pressed")
	pass



func _on_MenuButton_pressed(id):
	dropmenu.text=dropmenu.get_popup().get_item_text(id/10)

	
func save_data(path, data):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_var(data)
	
	file.close()

func load_data(path):
	var file = File.new()
	var content
	file.open(path,File.READ)
	content= file.get_var()
	file.close()
	return content


func _on_Save_pressed():
	
	save_data(savedir + input_text.text+ ".dat", GlobalVariable.VikingRts)
	reloadsaves()

	
func _on_Load_pressed():
	var dict=load_data(savedir + dropmenu.text + ".dat")
	for key in dict:
		if GlobalVariable.VikingRts.has(key):
			GlobalVariable.VikingRts[key]=dict[key]

