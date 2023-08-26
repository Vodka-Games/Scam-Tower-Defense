extends Area2D

var follwer: PathFollow2D
@export var speed :int

@export var max_hp:int
var hp:int

var id: int
var rng = RandomNumberGenerator.new()

func _ready():
	follwer = get_parent()
	hp = max_hp
	id = rng.randi()

func _physics_process(delta):
	follwer.progress += delta * speed
	
func get_progress():
	return follwer.progress

func damage(d):
	hp -= d
	
	if hp <= 0:
		follwer.queue_free()
