class_name Bullet
extends Node2D

@export var homing_strength := 5.0
@onready var movement := $Movement
@onready var torpedo_boom := $TorpedoBoomParticle
@onready var sprite := $Sprite2D
@onready var explosion := $Explosion
var direction := Vector2.ZERO
var target: Node2D = null


func _ready() -> void:
	$ShootTorpedoSound.play()
	explosion.disable()
	
	homing_strength = EntityManager.player_stats.torpedo_homing


func init(global_position: Vector2, direction: Vector2, rotation: float, layer: int, mask: int, damage: int) -> void:
	self.global_position = global_position
	self.direction = direction
	
	self.rotation = rotation
	
	var hit_box := $HitBox
	hit_box.collision_layer = layer
	hit_box.collision_mask = mask
	hit_box.damage = damage
	
	$MaxDistance.start_position = self.global_position
	

func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		var direction_to := (target.global_position - global_position).normalized()
		direction = direction.lerp(direction_to, homing_strength * delta)
		rotation = direction.angle()
	else:
		target = null
	
	movement.move(direction, delta)


func _on_hit_box_hit(_global_position: Vector2) -> void:
	torpedo_boom.emitting = true
	$TorpedoExplosionSound.play()
	$HitBox.disable()
	sprite.visible = false
	set_physics_process(false)
	explosion.enable()


func _on_max_distance_reached() -> void:
	queue_free()


func _on_torpedo_explosion_sound_finished() -> void:
	queue_free()


func _on_homing_area_entered(area: Area2D) -> void:
	if target != null:
		return
	if area is HurtBox:
		target = area.entity
