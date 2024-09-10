class_name Unit
extends Node2D

@export var speed: float = 100
@onready var anim_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var path: Path2D = %Path2D
@onready var path_follow: PathFollow2D = %PathFollow2D
@onready var navigation: Navigation = %Navigation

var is_selected: bool = false
var is_moving: bool = false

func _ready() -> void:
	WD.grid_click.connect(_on_grid_clicked)
	anim_sprite.frame = randi_range(0, anim_sprite.sprite_frames.get_frame_count("idle")-1)

func _process(dt: float) -> void:
	if is_moving:
		path_follow.progress += speed * dt
		global_position = path_follow.global_position

		if path_follow.progress_ratio > 0.999:
			path.curve = Curve2D.new()
			is_moving = false
			anim_sprite.play("idle")

func _on_grid_clicked(click_pos: Vector2) -> void:
	if is_selected:
		var nav_path: = navigation.get_nav_path_array(global_position, click_pos)

		if nav_path.size() == 0:
			print("Grid clicked but not reachable (%s)" % click_pos)
			return

		path.curve = Curve2D.new()
		for point in nav_path:
			path.curve.add_point(point)
		path_follow.progress = 0
		is_moving = true
		anim_sprite.play("walk")
		print("%s is heading to %s, from %s" % [name, click_pos, global_position])
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
