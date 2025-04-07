class_name WeaponIcon
extends Sprite2D

@export var torpedo_texture: Texture2D
@export var laser_texture: Texture2D
@export var shock_texture: Texture2D
@onready var textures := [torpedo_texture, laser_texture, shock_texture]
@onready var movement := $Movement


func init(weapon: int) -> void:
	texture = textures[weapon]
	

func _physics_process(delta: float) -> void:
	movement.move(Vector2.UP, delta)


func _on_timer_timeout() -> void:
	queue_free()
