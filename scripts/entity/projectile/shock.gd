class_name Shock
extends Node2D


func _ready() -> void:
	$ShockBlastParticles.emitting = true
	$ShockSound.play()
	$AnimatedSprite2D.play("default")


func _on_timer_timeout() -> void:
	queue_free()
