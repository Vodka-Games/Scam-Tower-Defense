extends Area2D

var target = null
@export var speed: int

func _physics_process(delta):
	if not target == null:
		var dir = (target.global_position - self.global_position).normalized()
		self.global_position += speed * delta * dir
	
	var tar_ref = weakref(target)
	if tar_ref.get_ref() == null:
		queue_free()
		
func set_target(t):
	target = t
	
func _on_area_entered(area):
	if target == area:
		area.damage(1)
		queue_free()
