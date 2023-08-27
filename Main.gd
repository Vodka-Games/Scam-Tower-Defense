extends Node2D

signal gameover

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ui_ingame_pause():
	$UI/PauseMenu.open_pause_menu()
	
func _on_start_pressed():
	$%Spawner.start_phase() # TODO: update
	$%UI_ingame.start_phase()
	$%UI_store.hide()
	
func _on_gameover():
	$%GameOver.show()
