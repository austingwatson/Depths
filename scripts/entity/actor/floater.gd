class_name Floater
extends Node2D

@export var heal: int
@onready var movement := $Movement
@onready var fish_sprite := $FishSprite
@onready var death_pop := $DeathPop
var direction := Vector2.ZERO


func _ready() -> void:
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	

func _physics_process(delta: float) -> void:
	movement.move(direction, delta)
	
	if global_position.y <= 20:
		global_position.y = 20


func _on_hurt_box_dead() -> void:
	death_pop.emitting = true
	fish_sprite.visible = false
	ProjectileManager.call_deferred("add_health_orb", global_position, heal)


func _on_hurt_box_pinged(global_position: Vector2) -> void:
	fish_sprite.pinged(global_position)


func _on_death_pop_finished() -> void:
	#GlobalSignals.on_heal_player(4)
	queue_free()
