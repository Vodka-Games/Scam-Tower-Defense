extends Area2D

var follwer: PathFollow2D
@export var speed :int

@export var max_hp:int
var hp:int

func _ready():
	follwer = get_parent()
	hp = max_hp

func _physics_process(delta):
	follwer.progress += delta * speed
