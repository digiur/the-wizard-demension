class_name Unit
extends Path2D

@export var speed: float = 100

@onready var anim_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var path: Path2D = %Path2D
@onready var path_follow: PathFollow2D = %PathFollow2D
@onready var navigation: Navigation = %Navigation

var is_selected: bool = false
var is_moving: bool = false
var default_flip = false

func _ready() -> void:
	WD.grid_click.connect(_on_grid_clicked)

func _process(dt: float) -> void:
	if !is_moving:
		anim_sprite.flip_h = default_flip
	else:
		path_follow.progress += speed * dt
		set_flip(global_position, path_follow.position)
		global_position = path_follow.global_position

		if path_follow.progress_ratio > 0.999:
			pathfinding_complete()

func set_flip(pos: Vector2, target: Vector2) -> void:
	var dir = target - pos
	if is_zero_approx(dir.dot(Vector2.RIGHT)):
		anim_sprite.flip_h = default_flip
	else:
		anim_sprite.flip_h = dir.dot(Vector2.RIGHT) < 0

func pathfinding_complete() -> void:
	path.curve = Curve2D.new()
	is_moving = false
	anim_sprite.play("idle")

func _on_grid_clicked(click_pos: Vector2) -> void:
	if is_selected:
		print("%s is heading to %s, from %s" % [name, click_pos, global_position])
		path.curve = Curve2D.new()
		for point in navigation.get_nav_path(global_position, click_pos):
			path.curve.add_point(point)
		path_follow.progress = 0
		is_moving = true
		anim_sprite.play("run")

		deselect()

func _on_input_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				clicked()

func clicked() -> void:
	print("%s clicked" % name)
	get_viewport().set_input_as_handled()
	if is_selected:
		deselect()
	else:
		select()

func select() -> void:
		anim_sprite.use_parent_material = false
		is_selected = true

func deselect() -> void:
		anim_sprite.use_parent_material = true
		is_selected = false
