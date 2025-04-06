class_name HurtBox
extends Area2D

signal hurt(max_health: int, health: int)
signal healed(max_health: int, health: int)
signal dead

@export var infinite_health := false
@export var max_health: int
@export var health: int
@export var shape: Shape2D


func _ready() -> void:
	$CollisionShape2D.shape = shape


func take_damage(damage: int) -> void:
	if infinite_health:
		return
	
	health = min(health - damage, max_health)
	hurt.emit(max_health, health)
	if health <= 0:
		dead.emit()


func heal(heal: int) -> void:
	health = min(health + heal, max_health)
	healed.emit(max_health, health)
