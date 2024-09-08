extends Node2D

@export var seconds: float = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(seconds).timeout

	queue_free()
