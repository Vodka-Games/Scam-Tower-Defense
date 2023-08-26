extends Area2D

var tile_size = 96

@export var range:int
@export var attack_gap: float

var is_floating = false
var is_install = false

var enemies_in_range = {}

var target = null

var bullet_scene = preload("res://tower/bullet.tscn")

func _physics_process(delta):
	if is_floating:
		var m_pos = get_global_mouse_position()
		put_on_tile(m_pos)
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			install()
	
func _ready():
	is_floating = true
	$Range.shape.radius = range * tile_size
	$AttackTimer.wait_time = attack_gap
	
func install():
	is_floating = false
	is_install = true
	get_parent().install_tower(self)
	$AttackTimer.start()

func put_on_tile(pos):
	pos += Vector2.ONE * tile_size / 2
	self.global_position = floor(pos / tile_size) * tile_size

func _unhandled_input(event):
	print(event)
	if is_floating:
		if event is InputEventMouseButton:
			install()
		if event is InputEventMouseMotion:
			var m_pos = event.position
			put_on_tile(m_pos)
			
func refresh_enemies():
	for k in enemies_in_range:
		var enemy = enemies_in_range[k]
		
		if enemy == null:
			enemies_in_range.erase(k)
			continue
		
		var is_overlap = overlaps_area(enemy)
		
		if not is_overlap:
			enemies_in_range.erase(k)
			
func refresh_target():
	refresh_enemies()
	
	if enemies_in_range.size() == 0:
		target = null
		return
	
	self.target = get_max_progress_enemy()

func get_max_progress_enemy():
	var max_progress = -1
	var max_enemy = null
	
	for k in enemies_in_range:
		var e = enemies_in_range[k]
		var p = e.get_progress()
		
		if max_progress < p:
			max_progress = p
			max_enemy = e
			
	return max_enemy

func create_bullet(target):
	var b_ins = bullet_scene.instantiate()
	
	add_child(b_ins)
	b_ins.set_target(target)

func attack_target():
	if not target == null:
		create_bullet(target)

func _on_area_entered(area):
	enemies_in_range[area.id] = area
	
	if target == null:
		refresh_target()
		
func _on_area_exited(area):
	enemies_in_range.erase(area.id)
	
	if area == target:
		refresh_target()

func _on_attack_timer_timeout():
	attack_target()

