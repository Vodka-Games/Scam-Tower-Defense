extends TextureRect

func _ready():
	for child in get_children():
		var i = child.get_index()
		
		var on_press = func(): get_parent().emit_signal("click_tower_item",i)
		child.connect("pressed", on_press)
		
	Global.set_tower_display(self)

func update():
	for child in get_children():
		var i = child.get_index()
		
		var tower = Global.get_tower(i)
		if tower == null:
			child.texture_normal = null
			child.get_node('./Label').text = ''
		else:
			if child is TextureButton:
				child.texture_normal = Global.get_tower_img(tower['name'])
				child.get_node('./Label').text = str(tower['amount'])
