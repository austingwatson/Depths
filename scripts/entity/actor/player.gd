class_name Player
extends Node2D

const rotation_threshold := 0.1
@export var forward_texture: Texture2D
@export var left_texture: Texture2D
@export var right_texture: Texture2D
@export var weapon_energy: float
@export var thrust_energy: float
@onready var movement := $Movement
@onready var energy := $Energy
@onready var sprite := $Sprite2D
@onready var energy_amount := $EnergyAmount
@onready var radius_light := $RadiusLight
@onready var forward_light := $ForwardLight
@onready var emergency_light := $EmergencyLight
@onready var thrusting := $Thrusting
@onready var flicker := $Flicker
@onready var camera := $Camera2D
var no_power := false


func _ready() -> void:
	thrusting.paused = true
	
	var hurt_box := $HurtBox
	GlobalSignals.on_player_health_changed(hurt_box.max_health, hurt_box.health)


func _unhandled_input(_event: InputEvent) -> void:
	if no_power:
		return
	
	if Input.is_action_just_pressed("shoot"):
		var direction := Vector2.RIGHT.rotated(rotation)
		ProjectileManager.add_friendly_torpedo(global_position, direction, rotation, 1)
		energy.use_energy(weapon_energy)


func _physics_process(delta: float) -> void:
	var direction := Vector2.RIGHT.rotated(rotation)
	
	if no_power:
		movement.stop(direction, delta)
		return
	
	if Input.is_action_pressed("rotate"):
		var dir: float = movement.turn(get_global_mouse_position(), delta)
		if dir < -1.0 || dir > 1.0:
			dir *= -1
		if dir < -rotation_threshold:
			sprite.texture = right_texture
			energy_amount.position = Vector2(0.0, 1.0)
		elif dir > rotation_threshold:
			sprite.texture = left_texture
			energy_amount.position = Vector2(0.0, -1.0)
		else:
			sprite.texture = forward_texture
			energy_amount.position = Vector2(0.0, 0.0)
	else:
		sprite.texture = forward_texture
		energy_amount.position = Vector2(0.0, 0.0)
	
	if Input.is_action_pressed("thrust"):
		movement.move(direction, delta)
		thrusting.paused = false
		GlobalSignals.on_player_moved(global_position)
	else:
		movement.stop(direction, delta)
		thrusting.paused = true


func _on_hurt_box_hurt(max_health: int, health: int) -> void:
	GlobalSignals.on_player_health_changed(max_health, health)
	camera.apply_shake()


func _on_energy_energy_changed(max_energy: float, energy: float) -> void:
	var new_length := 10.0 * (energy / max_energy) - 8.0
	energy_amount.points[1] = Vector2(new_length, 0.0)


func _on_energy_no_energy() -> void:
	no_power = true
	radius_light.visible = false
	forward_light.visible = false
	#emergency_light.visible = true
	thrusting.paused = true
	flicker.start()


func _on_energy_charging() -> void:
	no_power = false
	radius_light.visible = true
	forward_light.visible = true
	emergency_light.visible = false
	thrusting.paused = false
	flicker.stop()


func _on_thrusting_timeout() -> void:
	energy.use_energy(thrust_energy)


func _on_flicker_timeout() -> void:
	emergency_light.visible = not emergency_light.visible
