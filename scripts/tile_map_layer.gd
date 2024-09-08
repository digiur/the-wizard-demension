extends TileMapLayer

const NO_WIDTH: int = -1
var astar: AStarGrid2D = AStarGrid2D.new()

func _ready() -> void:
	astar.region = get_used_rect()
	astar.cell_size = tile_set.tile_size
	astar.update()
	var from: = get_used_rect().position
	var to: = get_used_rect().end
	to.x = to.x -1
	to.y = to.y -1
	var path: = astar.get_id_path(from, to)
	print("tile_size %s" % tile_set.tile_size)
	print("get_used_rect %s" % get_used_rect())
	print("from %s" % from)
	print("to %s" % to)
	print(path) # prints (0, 0), (1, 1), (2, 2), (3, 3), (3, 4)
	# print(astar_grid.get_point_path(Vector2i(0, 0), Vector2i(3, 4))) # prints (0, 0), (16, 16), (32, 32), (48, 48), (48, 64)

func _process(delta: float) -> void:
	queue_redraw()
	pass

func _draw() -> void:
	var from: = get_used_rect().position
	var to: = get_used_rect().end
	to.x = to.x -1
	to.y = to.y -1
	var path: = astar.get_point_path(from, to)
	for i:int in range(1, path.size()):
		draw_line(path[i-1], path[i], Color.WEB_GREEN, NO_WIDTH, true)
