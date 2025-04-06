class_name MaxDistance
extends Node

signal reached

@export var entity: Node2D
@export var distance: float
@onready var start_position := entity.global_position


func _physics_process(_delta: float) -> void:
	if entity.global_position.distance_to(start_position) >= distance:
		reached.emit()
