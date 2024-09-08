@tool
extends CollisionShape2D
@onready var texture_rect: TextureRect = %TextureRect

func _process(delta: float) -> void:
	shape.size = texture_rect.size
