extends Control

func _process(delta):
	print($Background)
	$Background.get_rect().size.x = get_viewport().size.x
	$Background.get_rect().size.y = get_viewport().size.y
	$Background.rect_scale.x = get_viewport().size.x / $Background.texture.get_size().x
	$Background.rect_scale.y = get_viewport().size.y / $Background.texture.get_size().y
