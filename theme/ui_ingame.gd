extends Control

signal pause
signal click_tower_item
var elapsed_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var count = Global.get_count_enemies()
	%EnemiesDisplayer.text = "Enemy Left: "+ str(count)

func start_phase():
#	$ItemButtonList.update_tower_list()
	pass

func _on_pause_button_pressed():
	emit_signal("pause")

func _on_timer_timeout():
	elapsed_time += 1  # Assume the timer has a wait time of 1 second

	var minutes = int(elapsed_time / 60)
	var seconds = elapsed_time % 60

	%Label_Timer.text = "%02d:%02d" % [minutes, seconds]
