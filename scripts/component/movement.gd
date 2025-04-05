class_name Movement
extends Node

@export var entity: Node2D
@export var max_speed: float
@export var acceleration: float
@export var deceleration: float
@export var rotation_speed: float
var velocity := Vector2.ZERO
var speed: float


func move(direction: Vector2, delta: float) -> void:
	speed = min(speed + acceleration * delta, max_speed)
	velocity = direction.normalized() * speed
	entity.global_position += velocity * delta


func stop(direction: Vector2, delta: float) -> void:
	speed = max(speed - deceleration * delta, 0.0)
	velocity = direction.normalized() * speed
	entity.global_position += velocity * delta
	

func turn(target: Vector2, delta: float) -> void:
	var target_angle := (target - entity.global_position).angle()
	entity.rotation = lerp_angle(entity.rotation, target_angle, rotation_speed * delta)
