extends Node

const player_stats := preload("res://resources/player_stats.tres")
const research_scene := preload("res://scenes/entity/drops/resource_pickup.tscn")
@onready var non_y_sort := $NonYSort
@onready var y_sort := $YSort


func clear() -> void:
	for child in non_y_sort.get_children():
		child.queue_free()
	for child in y_sort.get_children():
		child.queue_free()


func add_entity(node: Node, y_sort: bool) -> void:
	if y_sort:
		self.y_sort.add_child(node)
	else:
		non_y_sort.add_child(node)


func add_research(global_position: Vector2) -> void:
	var research := research_scene.instantiate()
	research.global_position = global_position
	call_deferred("add_entity", research, true)
