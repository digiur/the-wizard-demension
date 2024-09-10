extends Node
class_name GnomePlace

@export var spawn_time: = 2
@export var mob_speed: int = 100
@export var MOB = preload("res://scenes/units/mob.tscn")

@onready var navigation: Navigation = %Navigation
@onready var target: Node2D = %AttackTarget
@onready var spawn: Node2D = %Spawn

var path: Path2D

func _ready() -> void:
	path = navigation.get_path_2d_node(spawn.global_position, target.global_position)

	if !path:
		push_warning("No nav path for gnome place, using crow path")
		path = Path2D.new()
		path.curve = Curve2D.new()
		path.curve.add_point(spawn.position)
		path.curve.add_point(target.position)
		return

	path.y_sort_enabled = true
	add_child(path)

	get_tree().create_timer(spawn_time).timeout.connect(spawn_mob)

func spawn_mob() -> void:
	var mob: = MOB.instantiate()
	mob.speed = mob_speed
	path.add_child(mob)
	get_tree().create_timer(spawn_time).timeout.connect(spawn_mob)
