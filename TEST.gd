extends Sprite
func _ready():
	
	pass
var cam

func _physics_process(delta):
	cam = get_tree().current_scene.get_node("PlayerCam")
	self.scale = get_viewport().size * cam.zoom / self.texture.get_size()
	self.position = cam.position
	pass
