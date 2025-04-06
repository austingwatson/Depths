class_name Floater
extends Node2D

@export var heal: int


func _ready() -> void:
	$AnimationPlayer.play("idle")


func _on_hurt_box_dead() -> void:
	GlobalSignals.on_heal_player(heal)
	queue_free()


func _on_hurt_box_pinged() -> void:
	pass
