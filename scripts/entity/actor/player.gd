class_name Player
extends Node2D

@export var weapon_energy: int
@onready var movement := $Movement
@onready var energy := $Energy
var rotate_down := false


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and energy.has_energy(weapon_energy):
		var direction := Vector2.RIGHT.rotated(rotation)
		ProjectileManager.add_friendly_torpedo(global_position, direction, 1)
		energy.use_energy(weapon_energy)


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("rotate"):
		movement.turn(get_global_mouse_position(), delta)
	
	var direction := Vector2.RIGHT.rotated(rotation)
	if Input.is_action_pressed("thrust"):
		movement.move(direction, delta)
	else:
		movement.stop(direction, delta)


func _on_hurt_box_hurt(max_health: int, health: int) -> void:
	print(health, "/", max_health)


func _on_energy_energy_changed(max_energy: float, energy: float) -> void:
	print(energy, "/", max_energy)
