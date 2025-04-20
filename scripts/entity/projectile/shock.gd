class_name Shock
extends Node2D


func _ready() -> void:
	$ShockBlastParticles.emitting = true
	$ShockSound.play()
	$Shock_visual_rank1.play("default")


func _on_timer_timeout() -> void:
	queue_free()
