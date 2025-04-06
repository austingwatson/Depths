class_name Player
extends Node2D

const rotation_threshold := 0.1
@export var forward_texture: Texture2D
@export var left_texture: Texture2D
@export var right_texture: Texture2D
@export var weapon_energy: int
@onready var movement := $Movement
@onready var energy := $Energy
@onready var sprite := $Sprite2D


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and energy.has_energy(weapon_energy):
		var direction := Vector2.RIGHT.rotated(rotation)
		ProjectileManager.add_friendly_torpedo(global_position, direction, rotation, 1)
		energy.use_energy(weapon_energy)


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("rotate"):
		var dir: float = movement.turn(get_global_mouse_position(), delta)
		if dir < -1.0 || dir > 1.0:
			dir *= -1
		if dir < -rotation_threshold:
			sprite.texture = right_texture
		elif dir > rotation_threshold:
			sprite.texture = left_texture
		else:
			sprite.texture = forward_texture
	else:
		sprite.texture = forward_texture
	
	var direction := Vector2.RIGHT.rotated(rotation)
	if Input.is_action_pressed("thrust"):
		movement.move(direction, delta)
	else:
		movement.stop(direction, delta)


func _on_hurt_box_hurt(max_health: int, health: int) -> void:
	print(health, "/", max_health)


func _on_energy_energy_changed(max_energy: float, energy: float) -> void:
	print(energy, "/", max_energy)
