extends Node2D

signal end_phase

var path
var waves = []
var cur_w

var count_phase = 0

var loaded_waves = []
var rng = RandomNumberGenerator.new()

	
func load_wave_in_directory(path):
	var dir = DirAccess.open(path)
	if dir == null:
		print("An error occurred when trying to access the path.")
	for file_name in dir.get_files():
		
		var name = file_name.get_basename()
		var file_path = path + file_name
		var wave_scene = load(file_path)
		loaded_waves.append(wave_scene)

func update_phase():
	for c in get_children():
		if c is Timer:
			continue
		else:
			remove_child(c)
	for w in waves:
		print(w)
		
	for j in range(count_phase):
		var i = rng.randi_range(0,loaded_waves.size() - 1)
	
		var wave = loaded_waves[i]
	
		var ins_wave = wave.instantiate()
		add_child(ins_wave)
		waves.append(ins_wave)

func start_phase():
	if count_phase > 0:
		update_phase()
	start_spawn(path)
	
func _on_end_phase():
	count_phase += 1
	%UI_store.show()

func get_count_enemies():
	var enemies = find_children("*","Area2D", true)
	print(enemies)
	return enemies.size()
	
func _ready():
	load_wave_in_directory("res://map/level_1/wave/")
	for w in get_children():
		if not w is Timer:
			waves.append(w)
			
	Global.set_spawner(self)
	path = get_parent()

func start_spawn(p):
	if not waves.is_empty():
		cur_w = waves.pop_front()
		cur_w.start(p)
		
func end_wave_spawn():
	$PhaseTimer.wait_time = cur_w.wait
	$PhaseTimer.start()
	
func end_wave_timer():
	start_spawn(path)

func _on_phase_timer_timeout():
	end_wave_timer()
	
func finish_phase():
	$PhaseTimer.stop()



