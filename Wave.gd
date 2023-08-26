extends Node2D

signal spawn

@export var gap:float
@export var wait:float

var follower_scene = preload("res://spawner/follwer.tscn")
var path

var enemies = []

func _ready():
	for c in get_children():
		if c is Area2D:
			enemies.append(c)

func spawn_enemy():
	var c = enemies.pop_front()
	var follower = follower_scene.instantiate()
	
	path.call_deferred("add_child", follower)
		
	remove_child(c)
	follower.add_child(c)
	c.follower = follower
	c.show()
	
	if enemies.is_empty():
		print('stop')
		stop()
	else:
		$WaveTimer.wait_time = gap
		$WaveTimer.start()
	
func start(p):
	self.path = p
	spawn_enemy()
	
func stop():
	# end signal to parent
	$WaveTimer.stop()
	get_parent().end_wave_spawn()
	
func _on_wave_timer_timeout():
	spawn_enemy()
