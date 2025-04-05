class_name Detection
extends Area2D

signal detected(entity: Node2D)

@export var radius: float


func _ready() -> void:
	$CollisionShape2D.shape.radius = radius
