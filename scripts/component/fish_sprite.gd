class_name FishSprite
extends Node2D

@export var entity: Node2D
@export var base_animation: SpriteFrames
@export var outline_animation: SpriteFrames
@export var eye_animation: SpriteFrames
@export var visible_rect: Rect2
@export var show_time: float
@onready var outline := $Outline
@onready var pinged_timer := $PingedTimer
var on_screen := false


func _ready() -> void:
	$VisibleOnScreenNotifier2D.rect = visible_rect
	pinged_timer.wait_time = show_time
	$Base.sprite_frames = base_animation
	$Base.play("default")
	$Outline.sprite_frames = outline_animation
	$Outline.play("default")
	$Eye.sprite_frames = eye_animation
	$Eye.play("default")
	

func show_eyes() -> void:
	$Eye.visible = true


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	on_screen = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	on_screen = false
	

func pinged(global_position: Vector2) -> void:
	if on_screen:
		outline.visible = true
	else:
		ProjectileManager.add_arrow(global_position, entity.global_position)
	pinged_timer.start()


func _on_pinged_timer_timeout() -> void:
	outline.visible = false
