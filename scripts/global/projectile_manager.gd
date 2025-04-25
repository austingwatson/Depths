extends Node

const torpedo_scene := preload("res://scenes/entity/projectile/torpedo.tscn")
const arrow_scene := preload("res://scenes/entity/projectile/arrow.tscn")
const weapon_icon_scene := preload("res://scenes/entity/projectile/weapon_icon.tscn")
const health_orb_scene := preload("res://scenes/entity/drops/health_orb.tscn")
@export_flags_2d_physics var friendly_layer: int
@export_flags_2d_physics var friendly_mask: int

func add_friendly_torpedo(global_position: Vector2, target_position: Vector2, rotation: float, damage: int) -> void:
	var torpedo := torpedo_scene.instantiate()
	add_child(torpedo)
	torpedo.init(global_position, target_position, rotation, friendly_layer, friendly_mask, damage)
	

func add_arrow(global_position: Vector2, target_position: Vector2) -> void:
	var arrow := arrow_scene.instantiate()
	add_child(arrow)
	arrow.global_position = global_position
	arrow.look_at(target_position)
	arrow.rotation_degrees -= 90
	arrow.global_position += arrow.global_position.direction_to(target_position) * 100.0
	

func add_weapon_icon(global_position: Vector2, weapon: int) -> void:
	var weapon_icon := weapon_icon_scene.instantiate()
	add_child(weapon_icon)
	weapon_icon.global_position = global_position + (Vector2.UP * 32)
	weapon_icon.init(weapon)
	

func add_health_orb(global_position: Vector2, heal: int) -> void:
	var health_orb := health_orb_scene.instantiate()
	add_child(health_orb)
	health_orb.global_position = global_position
	health_orb.heal = heal
