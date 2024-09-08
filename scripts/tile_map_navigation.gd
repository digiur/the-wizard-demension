extends Node2D
class_name Navigation

var astar: AStarGrid2D = AStarGrid2D.new()

@onready var tile_map_layer: TileMapLayer = %TileMapLayer

func _ready() -> void:
	astar.region = tile_map_layer.get_used_rect()
	astar.diagonal_mode = 3
	astar.cell_size = tile_map_layer.tile_set.tile_size
	astar.offset = tile_map_layer.tile_set.tile_size / 2.0

	astar.update()

	var rect: = tile_map_layer.get_used_rect()
	for y: int in range(rect.position.y, rect.end.y):
		for x: int in range(rect.position.x, rect.end.x):
			if tile_map_layer.get_cell_source_id(Vector2i(x,y)) == -1:
				astar.set_point_solid(Vector2i(x,y), true)
