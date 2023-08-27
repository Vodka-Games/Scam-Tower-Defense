extends Node2D

var boom = preload("res://tower/Boom.tscn")

func _on_attack_timer_timeout():
	var control = get_node("../Control")
	control.hide()
	
	var b =  boom.instantiate()
	get_node("..").add_child(b)
	get_node("..").broken()
	get_node("../AttackTimer").stop()
	
	b.global_position = global_position
	
