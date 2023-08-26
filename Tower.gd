extends Sprite2D

var tile_size = 128

var is_floating = false
var is_install = false

func _physics_process(delta):
	pass
	
func _ready():
	is_floating = true
	
func install():
	is_floating = false
	is_install = true
	get_parent().install_tower(self)

func put_on_tile(pos):
	self.global_position = floor(pos / tile_size) * tile_size

func _unhandled_input(event):
	if is_floating:
		if event is InputEventMouseButton:
			install()
		elif event is InputEventMouseMotion:
			var m_pos = event.position
			put_on_tile(m_pos)
			
