extends Area2D


func _on_timer_timeout():
	$AnimationPlayer.play("boom")
	await $AnimationPlayer.animation_finished
	var areas = get_overlapping_areas()
	for a in areas:
		a.emit_signal("demage",5)
	queue_free()
