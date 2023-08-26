extends Node2D

var is_picking = false

func pick_tower(pos, tower):
	if is_picking:
		return
		
	self.is_picking = true
	var temp_tower = tower.instantiate()
		
	add_child(temp_tower)
	
	temp_tower.put_on_tile(pos)
	
func install_tower(obj):
	self.is_picking = false

func _on_ui_ingame_click_tower_item(idx):
	var tower = Global.get_tower(idx)
	var tower_scene = Global.get_tower_scene(tower['name'])
	
	var pos = get_global_mouse_position()
	pick_tower(pos, tower_scene)
