class_name Floater
extends Node2D

@export var heal: int
@onready var movement := $Movement
var direction := Vector2.ZERO


func _ready() -> void:
	$AnimationPlayer.play("idle")
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	

func _physics_process(delta: float) -> void:
	movement.move(direction, delta)


func _on_hurt_box_dead() -> void:
	GlobalSignals.on_heal_player(heal)
	queue_free()


func _on_hurt_box_pinged() -> void:
	pass
