class_name HitBox
extends Area2D

signal hurt(max_health: int, health: int)
signal dead

@export var max_health: int
@export var health: int


func damage(damage: int) -> void:
	health -= damage
	hurt.emit(max_health, health)
	if health <= 0:
		dead.emit()


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		damage(area.damage)
