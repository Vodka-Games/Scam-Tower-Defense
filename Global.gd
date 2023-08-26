extends Node

var money = 1000

var towers = []
var tower_dict = {}

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
			return true
	
	var item_dict = {}
	item_dict['name'] = tower_name
	item_dict['amount'] = 1
	
	towers.append(item_dict)
			

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
	
func get_tower_img(name):
	return tower_dict[name]['img']
