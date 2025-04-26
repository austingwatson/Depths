class_name Shock
extends Node2D

@export var upgrade_shape: Shape2D
var player_stats: PermStats = EntityManager.player_stats


func _ready() -> void:
	$ShockBlastParticles.emitting = true
	$ShockSound.play()
	$HitBox.damage = player_stats.damage + player_stats.shock_damage
	
	if player_stats.shock_range:
		$Shock_visual_rank2.visible = true
		$Shock_visual_rank2.play("default")
		$HitBox.collision_shape.shape = upgrade_shape
	else:
		$Shock_visual_rank1.visible = true
		$Shock_visual_rank1.play("default")


func _on_timer_timeout() -> void:
	queue_free()
