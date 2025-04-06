class_name Urchin
extends Node2D

@onready var movement := $Movement
var direction := Vector2.ZERO
var angry := false


func _ready() -> void:
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))


func _physics_process(delta: float) -> void:
	movement.move(direction, delta)
	

func _on_hurt_box_dead() -> void:
	queue_free()


func _on_hit_box_hit(global_position: Vector2) -> void:
	direction = -self.global_position.direction_to(global_position)
	
	if not angry:
		angry = true
		$AnimationPlayer.play("angry")
