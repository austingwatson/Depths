class_name HunterFish
extends Node2D

enum State {
	IDLE,
	MOVE_RAND,
	MOVE_TO_PLAYER,
	ATTACK,
}

@export var base: HunterFishMovement
@export var move_to_player: HunterFishMovement
@export var attack: HunterFishMovement
@export var attack_range := 0.0
@export var attack_fov_angle := 0.0
@onready var movement := $Movement
@onready var fish_sprite := $FishSprite
@onready var idle_timer := $IdleTimer
var direction := Vector2.ZERO
var state := State.IDLE
var target_position := Vector2.ZERO
var player: Node2D = null


func _ready() -> void:
	set_base_movement()
	attack_fov_angle = deg_to_rad(attack_fov_angle)


func _physics_process(delta: float) -> void:
	print(state)
	match state:
		State.IDLE:
			movement.stop(direction, delta)
			idle_timer.paused = false
		State.MOVE_RAND:
			movement.move(direction, delta)
			movement.turn(target_position, delta)
			if global_position.distance_to(target_position) <= 10.0:
				state = State.IDLE
		State.MOVE_TO_PLAYER:
			target_position = player.global_position
			direction = global_position.direction_to(target_position)
			movement.move(direction, delta)
			movement.turn(target_position, delta)
			
			if global_position.distance_to(target_position) < attack_range:
				var facing_direction := transform.x.normalized()
				var is_looking_at_player := facing_direction.dot(direction.normalized()) > cos(attack_fov_angle / 2)
				if is_looking_at_player:
					set_attack_movement()
					state = State.ATTACK
		State.ATTACK:
			movement.move(direction, delta)


func set_base_movement() -> void:
	movement.max_speed = base.max_speed
	movement.acceleration = base.acceleration
	movement.deceleration = base.deceleration
	movement.rotation_speed = base.rotation_speed
	

func set_move_player_movement() -> void:
	movement.max_speed = move_to_player.max_speed
	movement.acceleration = move_to_player.acceleration
	movement.deceleration = move_to_player.deceleration
	movement.rotation_speed = move_to_player.rotation_speed
	

func set_attack_movement() -> void:
	movement.max_speed = attack.max_speed
	movement.acceleration = attack.acceleration
	movement.deceleration = attack.deceleration
	movement.rotation_speed = attack.rotation_speed


func _on_hurt_box_dead() -> void:
	EntityManager.add_research(global_position)
	EntityManager.add_research(global_position)
	queue_free()


func _on_hurt_box_hurt(max_health: int, health: int) -> void:
	pass # Replace with function body.


func _on_hurt_box_pinged(global_position: Vector2) -> void:
	fish_sprite.pinged(global_position)


func _on_player_detection_detected(entity: Node2D) -> void:
	if entity is Player:
		player = entity
		target_position = player.global_position
		direction = global_position.direction_to(target_position)
		state = State.MOVE_TO_PLAYER
		set_move_player_movement()


func _on_idle_timer_timeout() -> void:
	idle_timer.paused = true
	if state == State.IDLE:
		target_position = global_position + Vector2(randf_range(-1000, 1000), randf_range(-1000, 1000))
		direction = global_position.direction_to(target_position)
		state = State.MOVE_RAND
