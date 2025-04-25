class_name Shock
extends Node2D

var player_stats: PermStats = EntityManager.player_stats


func _ready() -> void:
	$ShockBlastParticles.emitting = true
	$ShockSound.play()
	$Shock_visual_rank1.play("default")
	$HitBox.damage = player_stats.damage + player_stats.shock_damage


func _on_timer_timeout() -> void:
	queue_free()
