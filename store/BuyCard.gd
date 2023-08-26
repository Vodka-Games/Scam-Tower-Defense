extends Panel

@export var cost:int
@export var tower_name:String

func _ready():
	$Label.text = str(cost)

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			Global.buy_tower(tower_name,cost)
			# add tower to list
