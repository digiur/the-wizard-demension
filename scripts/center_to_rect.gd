@tool
extends Area2D

@onready var texture_rect: TextureRect = %TextureRect

func _process(delta: float) -> void:
	position.x = texture_rect.position.x + texture_rect.size.x / 2
	position.y = texture_rect.position.y + texture_rect.size.y / 2
