extends Node2D

@export var gap:float
@export var wait:float

var follower_scene = preload("res://spawner/follwer.tscn")

func spawn_wave(p):
	for c in get_children():
		var follower = follower_scene.instantiate()
		p.call_deferred("add_child", follower)
		
		self.remove_child(c)
		follower.add_child(c)
		c.follower = follower
		c.show()
		
		await get_tree().create_timer(gap).timeout
