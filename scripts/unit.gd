class_name Unit
extends Path2D

@export var speed: float = 100
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var targetPosition: Vector2 = self.position
@onready var navigation: Navigation = %Navigation
@onready var tile_map_layer: TileMapLayer = %TileMapLayer
@onready var path_follow_2d: PathFollow2D = %PathFollow2D

const PARTICLES_CRYSTALS = preload("res://scenes/particles/particles_crystals.tscn")

var is_selected: bool = false
var is_moving: bool = false

func _ready() -> void:
	WD.grid_click.connect(_on_grid_clicked)
	curve.add_point(Vector2.ZERO)

func _process(dt: float) -> void:
	animated_sprite_2d.flip_h = position.x > targetPosition.x

	if is_moving:
		path_follow_2d.progress += speed * dt
		
	if path_follow_2d.progress_ratio > 0.999:
		position = path_follow_2d.global_position
		path_follow_2d.progress = 0
		curve = Curve2D.new()
		curve.add_point(Vector2.ZERO)
		is_moving = false

func _on_grid_clicked(click_pos: Vector2) -> void:
	if is_selected:
		position = path_follow_2d.global_position
		path_follow_2d.progress = 0
		var particles_crystals: = PARTICLES_CRYSTALS.instantiate() as CPUParticles2D
		particles_crystals.global_position = click_pos
		particles_crystals.restart()
		get_tree().get_root().add_child(particles_crystals)
		var from = tile_map_layer.local_to_map(global_position)
		var to = tile_map_layer.local_to_map(click_pos)
		build_path_curve(navigation.astar.get_point_path(from, to, true))
		targetPosition = click_pos
		is_moving = true
		path_follow_2d.progress = 0.0
		deselect()
	else:
		print("%s unselected, ignoring grid click" % name)
		
func build_path_curve(path: PackedVector2Array):
	curve = Curve2D.new()
	for v in path:
		curve.add_point(to_local(v))

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				clicked()

func clicked() -> void:
	get_viewport().set_input_as_handled()
	if is_selected:
		deselect()
	else:
		select()

func select():
	print("%s Selected" % name)
	animated_sprite_2d.use_parent_material = false
	is_selected = true

func deselect():
	print("%s De-Selected" % name)
	animated_sprite_2d.use_parent_material = true
	is_selected = false
