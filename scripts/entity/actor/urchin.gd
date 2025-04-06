class_name Urchin
extends Node2D


func _on_hurt_box_dead() -> void:
	queue_free()


func _on_hit_box_hit() -> void:
	$AnimationPlayer.play("angry")
	$HitBox.hit.disconnect(_on_hit_box_hit)
