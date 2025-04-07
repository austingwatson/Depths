class_name ResourcePickup
extends Area2D

@export var worth := 1
@onready var collision_shape := $CollisionShape2D
@onready var scan_timer := $ScanTimer
@onready var animated_sprite := $AnimatedSprite2D
@onready var movement := $Movement
@onready var research_pickup_sound := $ResearchPickup
var scanned := false
var direction := Vector2.ZERO


func _ready() -> void:
	animated_sprite.play("default")
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	

func _physics_process(delta: float) -> void:
	movement.stop(direction, delta)


func start_scan() -> void:
	if not scanned:
		scan_timer.start()
		research_pickup_sound.play()
	

func end_scan() -> void:
	scan_timer.stop()
	research_pickup_sound.stop()


func _on_scan_timer_timeout() -> void:
	scanned = true
	collision_shape.set_deferred("disabled", true)
	EntityManager.player_stats.add_research(worth)
	animated_sprite.play("pop")


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "pop":
		queue_free()
