extends TextureRect

func _ready():
	for child in get_children():
		var i = child.get_index()
		
		var on_press = func(): get_parent().emit_signal("click_tower_item",i)
		child.connect("pressed", on_press)
