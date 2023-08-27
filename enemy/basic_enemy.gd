extends Area2D

var follower = null
@export var speed :int

@export var max_hp:int
var hp:int

var id: int
var rng = RandomNumberGenerator.new()

var is_blocking = false
var target = null

func _ready():
	var parent = get_parent()
	
	if parent is PathFollow2D:
		follower = parent
		
	hp = max_hp
	id = rng.randi()
	
	hide()

func _physics_process(delta):
	if is_blocking:
		return
		
	if not follower is PathFollow2D:
		return
		
	if follower.progress_ratio > 0.95:
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
		# TODO: change to broken image

func attack_target():
	pass


func _on_area_entered(area):
	if area.name == "HitBox":
		is_blocking = true
		$AttackTimer.start()

func _on_area_exited(area):
	if area.name == "HitBox":
		is_blocking = false


func _on_attack_timer_timeout():
	attack_target()
