@tool
extends Node2D

@export var circle_nodes: Array[Node2D]

@export var palete: = [Color.WEB_GREEN, Color.WEB_MAROON, Color.WEB_PURPLE]

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circles(circle_nodes)

func draw_circles(circle_nodes: Array[Node2D]):
		var i: = 0
		for node in circle_nodes:

			if !node:
				continue

			draw_circle(node.global_position - global_position, 10, palete[i], false)
			i = (i + 1) % palete.size()
