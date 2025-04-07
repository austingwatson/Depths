class_name HunterFish
extends Node2D

enum State {
	IDLE,
	MOVE_RAND,
	MOVE_SUB,
	ATTACK,
}

@onready var fish_sprite := $FishSprite
@onready var movement := $Movement
@onready var idle_timer := $IdleTimer
@onready var attack_timer := $AttackTimer
@onready var hit_box := $HitBox
var player: Player = null
var state := State.IDLE
var direction := Vector2.ZERO
var rand_target := Vector2.ZERO


func _ready() -> void:
	state = State.MOVE_RAND
	rand_target = global_position + Vector2(randf_range(-500, 500), randf_range(-500, 500))
	hit_box.disable()


func _physics_process(delta: float) -> void:
	idle_timer.paused = true
	attack_timer.paused = true
	
	match state:
		State.IDLE:
			movement.stop(direction, delta)
			idle_timer.paused = false
		State.MOVE_RAND:
			direction = global_position.direction_to(rand_target)
			movement.move(direction, delta)
			movement.turn(rand_target, delta)
			if global_position.distance_to(rand_target) <= 10.0:
				state = State.IDLE
		State.MOVE_SUB:
			direction = global_position.direction_to(player.global_position)
			movement.move(direction, delta)
			movement.turn(player.global_position, delta)
		State.ATTACK:
			attack_timer.paused = false
	
	if global_position.y <= 20:
		global_position.y = 20


func _on_hurt_box_dead() -> void:
	queue_free()


func _on_hurt_box_pinged() -> void:
	fish_sprite.pinged()


func _on_detection_detected(entity: Node2D) -> void:
	if entity is Player and state != State.ATTACK:
		player = entity
		state = State.MOVE_SUB
		fish_sprite.show_eyes()


func _on_detection_lost(entity: Node2D) -> void:
	if entity is Player and state != State.ATTACK:
		player = null
		state = State.IDLE


func _on_attack_detection_detected(entity: Node2D) -> void:
	if entity is Player:
		state = State.ATTACK


func _on_idle_timer_timeout() -> void:
	state = State.MOVE_RAND
	rand_target = global_position + Vector2(randf_range(-500, 500), randf_range(-500, 500))


func _on_attack_timer_timeout() -> void:
	state = State.IDLE
	hit_box.enable()


func _on_hit_box_hit(_global_position: Vector2) -> void:
	hit_box.disable()
