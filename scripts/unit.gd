class_name Unit
extends Node2D

@export var speed: float = 100
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var targetPosition: Vector2 = self.position

const PARTICLES_CRYSTALS = preload("res://scenes/particles/particles_crystals.tscn")

var is_selected: bool = false

func _ready() -> void:
	WD.grid_click.connect(_on_grid_clicked)
	
func _process(dt: float) -> void:
	animated_sprite_2d.flip_h = position.x > targetPosition.x

	if (position - targetPosition).length_squared() < 9:
		animated_sprite_2d.play("idle")
	else:
		position = position.move_toward(targetPosition, speed * dt)
		animated_sprite_2d.play("run")

func _on_grid_clicked(click_pos: Vector2) -> void:
	if is_selected:
		var particles_crystals: = PARTICLES_CRYSTALS.instantiate() as CPUParticles2D
		particles_crystals.global_position = click_pos
		particles_crystals.restart()
		get_tree().get_root().add_child(particles_crystals)
		targetPosition = click_pos
		deselect()
	else:
		print("%s unselected, ignoring grid click" % name)

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
