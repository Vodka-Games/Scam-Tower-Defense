extends Node2D

signal gameover

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.money = 500
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


func _on_pause_menu_back_to_main_pressed():
	get_tree().change_scene_to_file("res://addons/EasyMenus/Scenes/main_menu.tscn")
	pass # Replace with function body.
