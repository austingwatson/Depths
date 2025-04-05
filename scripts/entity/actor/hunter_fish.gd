class_name HunterFish
extends Node2D

enum State {
	IDLE,
	MOVE_RAND,
	MOVE_SUB,
	ATTACK,
}





func _on_hurt_box_dead() -> void:
	queue_free()
