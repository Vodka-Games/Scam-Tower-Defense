extends Control

signal click_tower_item

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
#	%Label_Timer.text = 
	pass # Replace with function body.

func _on_click_tower_item(event, tower):
	emit_signal("click_tower_item",[event, tower])
