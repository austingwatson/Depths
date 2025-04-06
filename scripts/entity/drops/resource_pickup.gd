class_name ResourcePickup
extends Area2D

@export var worth := 1
@onready var collision_shape := $CollisionShape2D
@onready var scan_timer := $ScanTimer
var scanned := false


func start_scan() -> void:
	if not scanned:
		scan_timer.start()
	

func end_scan() -> void:
	scan_timer.stop()


func _on_scan_timer_timeout() -> void:
	scanned = true
	collision_shape.set_deferred("disabled", true)
	EntityManager.player_stats.add_research(worth)
