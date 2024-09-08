extends Node2D

@export var grid_size: int = 32

func _physics_process(delta):
	var v: Vector2 = get_viewport().get_mouse_position() / grid_size 
	self.position = v.floor() * grid_size
