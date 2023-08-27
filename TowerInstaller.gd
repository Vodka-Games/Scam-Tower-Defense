extends Node2D

var is_picking = false

func init():
	is_picking = false

func pick_tower(pos, tower):
	if is_picking:
		return
		
	self.is_picking = true
	var temp_tower = tower.instantiate()
		
	add_child(temp_tower)
	
	temp_tower.put_on_tile(pos)
	return temp_tower
	
func install_tower(name, pos):
	self.is_picking = false
	Global.install_tower(name, pos)

func _on_ui_ingame_click_tower_item(idx):
	var tower = Global.get_tower(idx)
	if tower == null:
		return 
		
	var tower_scene = Global.get_tower_scene(tower['name'])
	
	var pos = get_global_mouse_position()
	var temp_tower = pick_tower(pos, tower_scene)
	
	temp_tower.tower_name = tower['name']
