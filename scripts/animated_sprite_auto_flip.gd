extends AnimatedSprite2D
class_name AutoFlipSprite

@onready var default_flip = flip_h
@onready var last_pos: Vector2 = global_position

func _process(delta: float) -> void:
	var dir = global_position - last_pos

	if is_zero_approx(dir.dot(Vector2.RIGHT)):
		flip_h = default_flip
	else:
		flip_h = dir.dot(Vector2.RIGHT) < 0

	last_pos = global_position
