class_name Spawner
extends Node2D

enum Type {
	FISH,
	URCHIN,
	FLOATER,
	RESEARCH,
	BIG_FLOATER,
	DEEP_FISH,
}

@export var disable := false
@export var type := Type.FISH
@export var enemy_scene: PackedScene
@export var max_amount: Curve
@export var lower_spawn_curve: Curve
@export var upper_spawn_curve: Curve
@export var timer_curve: Curve
@export var spawn_locations = [
	{"value": "up", "weight": 25},
	{"value": "left", "weight": 25},
	{"value": "down", "weight": 25},
	{"value": "right", "weight": 25},
]
@export var margin: float
@onready var spawn_timer := $SpawnTimer
var current_amount := 0
var player_y := 0.0


func _ready() -> void:
	if disable:
		queue_free()
	else:
		GlobalSignals.player_moved.connect(_on_player_moved)
		spawn_timer.start(timer_curve.sample(player_y))


func pick_random_dir():
	var total_weight = 0
	for option in spawn_locations:
		total_weight += option.weight  # Sum up all weights

	var random_pick = randf() * total_weight  # Pick a random point in the total weight range
	var current_weight = 0

	for option in spawn_locations:
		current_weight += option.weight
		if random_pick <= current_weight:
			return option.value  # Return the chosen value

	return null  # Fallback (should never happen)


func get_enemy_amount() -> int:
	return randi_range(lower_spawn_curve.sample(player_y), upper_spawn_curve.sample(player_y))
	

func get_random_position() -> Vector2:
	var screen_size := get_viewport_rect().size / 2
	var dir: String = pick_random_dir()
	
	var spawn_pos := get_viewport().get_camera_2d().global_position
	match dir:
		"up":
			spawn_pos += Vector2(randf_range(-screen_size.x - margin, screen_size.x + margin), -screen_size.y * 2 - margin)
		"left":
			spawn_pos += Vector2(-screen_size.x - margin, randf_range(-screen_size.y - margin, screen_size.y * 2 + margin))
		"down":
			spawn_pos += Vector2(randf_range(-screen_size.x * 2 - margin, screen_size.x + margin), screen_size.y + margin)
		"right":
			spawn_pos += Vector2(screen_size.x * 2 + margin, randf_range(-screen_size.y - margin, screen_size.y + margin))
	
	#spawn_pos = get_viewport().get_camera_2d().global_position
	return spawn_pos


func _on_spawn_timer_timeout() -> void:
	match type:
		Type.FISH:
			current_amount = get_tree().get_node_count_in_group("Fish")
		Type.URCHIN:
			current_amount = get_tree().get_node_count_in_group("Urchin")
		Type.FLOATER:
			current_amount = get_tree().get_node_count_in_group("Floater")
		Type.RESEARCH:
			current_amount = get_tree().get_node_count_in_group("Research")
		Type.BIG_FLOATER:
			current_amount = get_tree().get_node_count_in_group("BigFloater")
		Type.DEEP_FISH:
			current_amount = get_tree().get_node_count_in_group("DeepFish")
	
	var amount := get_enemy_amount()
	var max: int = round(max_amount.sample(player_y))
	while current_amount + amount > max:
		amount -= 1
		if amount == 0:
			break
	
	for i in range(amount):
		var enemy := enemy_scene.instantiate()
		enemy.global_position = get_random_position()
		EntityManager.add_entity(enemy, true)
	
	spawn_timer.start(timer_curve.sample(player_y))
	

func _on_player_moved(global_position: Vector2) -> void:
	player_y = global_position.y
