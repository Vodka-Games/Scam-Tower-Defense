extends Area2D

var follower = null
@export var speed :int

@export var max_hp:int
var hp:int

var id: int
var rng = RandomNumberGenerator.new()

func _ready():
	var parent = get_parent()
	
	if parent is PathFollow2D:
		follower = parent
		
	hp = max_hp
	id = rng.randi()
	
	hide()

func _physics_process(delta):
	if not follower is PathFollow2D:
		return
	if follower.progress_ratio > 0.1:
		gameover()
		
	follower.progress += delta * speed
	
func get_progress():
	return follower.progress
	
func gameover():
	var main = get_tree().root.get_node('/root/Main')
	main.emit_signal("gameover")

func damage(d):
	hp -= d
	
	if hp <= 0:
		follower.queue_free()
		Global.decrease_enemies()
