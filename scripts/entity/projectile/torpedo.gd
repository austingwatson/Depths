class_name Bullet
extends Node2D

@onready var movement := $Movement
var direction := Vector2.ZERO


func init(global_position: Vector2, direction: Vector2, rotation: float, layer: int, mask: int, damage: int) -> void:
	self.global_position = global_position
	self.direction = direction
	
	$Sprite2D.rotation = rotation
	
	var hit_box := $HitBox
	hit_box.collision_layer = layer
	hit_box.collision_mask = mask
	hit_box.damage = damage
	
	$MaxDistance.start_position = self.global_position
	

func _physics_process(delta: float) -> void:
	movement.move(direction, delta)


func _on_hit_box_hit(_global_position: Vector2) -> void:
	queue_free()


func _on_max_distance_reached() -> void:
	queue_free()
