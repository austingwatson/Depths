class_name HurtBox
extends Area2D

signal hurt(max_health: int, health: int)
signal dead

@export var max_health: int
@export var health: int


func take_damage(damage: int) -> void:
	health -= damage
	hurt.emit(max_health, health)
	if health <= 0:
		dead.emit()
