extends Node2D

var path
var waves = []
var cur_idx = 0

func _ready():
	for c in get_children():
			waves.append(c)
	path = get_parent()
	start_spawn(path)
	
func start_spawn(p):
	for w in waves:
		w.spawn_wave(p)
		await get_tree().create_timer(w.wait).timeout
