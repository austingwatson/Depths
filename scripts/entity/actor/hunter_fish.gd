class_name HunterFish
extends Node2D

enum State {
	IDLE,
	MOVE_RAND,
	MOVE_SUB,
	ATTACK,
}

@onready var fish_sprite := $FishSprite


func _on_hurt_box_dead() -> void:
	queue_free()


func _on_hurt_box_pinged() -> void:
	fish_sprite.pinged()
