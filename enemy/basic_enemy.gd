extends Area2D

var follower = null
@export var speed :int

@export var max_hp:int
var hp:int

var id: int
var rng = RandomNumberGenerator.new()

var is_blocking = false
var target = []

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
	if hp <= 0:
		return
		
	hp -= d
	
	if hp <= 0:
		Global.decrease_enemies()
		$AnimationPlayer.play("break")
		await $AnimationPlayer.animation_finished
		follower.queue_free()
		# TODO: change to broken image

func attack_target():
	var tar_ref = weakref(target)
	if tar_ref.get_ref() != null:
		target.damage(1)
	else:
		target = false
		$AttackTimer.stop()

func _on_area_entered(area):
	if area.name == "HitBox":
		is_blocking = true
		$AttackTimer.start()
		target = area.get_parent()

func _on_area_exited(area):
	if area.name == "HitBox":
		is_blocking = false
		target = null

func _on_attack_timer_timeout():
	attack_target()
