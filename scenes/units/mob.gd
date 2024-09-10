extends PathFollow2D

@export var speed: int = 100

func _process(dt: float) -> void:
	progress += speed * dt
	if progress_ratio >= 1.0:
		queue_free()
