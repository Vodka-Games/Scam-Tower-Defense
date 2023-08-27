extends Node

var money = 1000
var count_enemies = 0

var towers = []
var tower_dict = {}
var installed_tiles = []

var tower_display = null
var spawner = null

func set_tower_display(obj):
	tower_display = obj

func update_display():
	tower_display.update()

func load_tower():
	var tower_path = "res://tower/var/"
	load_tower_in_directory(tower_path)
	load_tower_img(tower_path)

func load_tower_in_directory(path):
	var dir = DirAccess.open(path)
	if dir == null:
		print("An error occurred when trying to access the path.")
	for file_name in dir.get_files():
		
		var name = file_name.get_basename()
		var file_path = path + file_name
		
		var d = {}
		d['name'] = name
		d['scene'] = load(file_path)
		
		tower_dict[name] = d
	
func load_tower_img(path):
	var img_path = path + "img/"
	var img_dir = DirAccess.open(img_path)
	
	for name in tower_dict:
		tower_dict[name]['img'] = load(img_path + name + ".png")
	
func _ready():
	load_tower()
	
func _process(delta):
	pass
	
func get_money():
	return money 

func buy_tower(tower_name, amount):
	var ret = buy_item(amount)
	
	if not ret:
		return false
	
	for tower in towers:
		if tower['name'] == tower_name:
			tower['amount'] += 1
			update_display()
			return true
	
	var item_dict = {}
	item_dict['name'] = tower_name
	item_dict['amount'] = 1
	
	towers.append(item_dict)
	update_display()

func buy_item(amount):
	if money < amount:
		return false
	else:
		money -= amount
		return true
		
func get_tower(idx):
	if idx >= towers.size():
		return null
	return towers[idx]
	
func get_tower_scene(name):
	return tower_dict[name]['scene']
	
func get_tower_img(name):
	return tower_dict[name]['img']
	
func set_count_enemies(amount, spawner):
	count_enemies = amount
	
	self.spawner = spawner
	
func decrease_enemies():
	count_enemies -= 1
	assert(count_enemies >= 0)
	
	if count_enemies == 0:
		spawner.emit_signal("end_phase")
	
func get_count_enemies():
	return count_enemies
	
func install_tower(tower_name, pos):
	for i in towers.size():
		if  towers[i]['name'] == tower_name:
			towers[i]['amount'] -= 1
			
			if towers[i]['amount'] == 0:
				towers.pop_at(i)
				
	var b_pos = floor(pos / 96)
	installed_tiles.append(b_pos)
	update_display()
	
func get_installed_tiles():
	return installed_tiles
