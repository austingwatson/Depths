class_name CharacterMovement
extends Node

@export var character_body: CharacterBody2D
@export var speed: float


func _physics_process(_delta: float) -> void:
	character_body.move_and_slide()
	

func set_direction(direction: Vector2) -> void:
	character_body.velocity = direction.normalized() * speed
