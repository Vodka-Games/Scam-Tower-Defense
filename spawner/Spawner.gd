extends Node2D

var path
var waves = []
var cur_w

func start_phase():
	var count = get_count_enemies()
	Global.set_count_enemies(count)
	start_spawn(path)

func get_count_enemies():
	var enemies = find_children("*","Area2D", true)
	return enemies.size()
	
func _ready():
	for w in get_children():
		if not w is Timer:
			waves.append(w)
			
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
