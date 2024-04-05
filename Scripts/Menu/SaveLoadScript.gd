extends Node2D

onready var GlobalVariable= get_node("/root/GlobalVariables")
onready var input_text : LineEdit  = get_node("Panel/Input")
onready var output_text : Label  = get_node("Panel/Output")

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
	
	save_data("user://" + input_text.text+ ".dat", GlobalVariable.VikingRts)


	
func _on_Load_pressed():
	var dict=load_data("user://"+ input_text.text + ".dat")
	for key in dict:
		if GlobalVariable.VikingRts.has(key):
			GlobalVariable.VikingRts[key]=dict[key]

