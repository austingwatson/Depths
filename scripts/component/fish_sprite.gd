class_name FishSprite
extends Node2D

@export var entity: Node2D
@export var base_animation: SpriteFrames
@export var outline_animation: SpriteFrames
@export var eye_animation: SpriteFrames
@export var visible_rect: Rect2
@export var show_time: float
@onready var base := $Base
@onready var outline := $Outline
@onready var eyes := $Eye
@onready var pinged_timer := $PingedTimer
var on_screen := false


func _ready() -> void:
	$VisibleOnScreenNotifier2D.rect = visible_rect
	pinged_timer.wait_time = show_time
	base.sprite_frames = base_animation
	base.play("default")
	outline.sprite_frames = outline_animation
	outline.play("default")
	eyes.sprite_frames = eye_animation
	eyes.play("default")
	

func show_base() -> void:
	base.visible = true


func hide_base() -> void:
	base.visible = false
	

func show_eyes() -> void:
	eyes.visible = true
	

func hide_eyes() -> void:
	eyes.visible = false


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	on_screen = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	on_screen = false
	

func pinged(global_position: Vector2) -> void:
	if on_screen:
		outline.visible = true
	else:
		outline.visible = true
		ProjectileManager.add_arrow(global_position, entity.global_position)
	pinged_timer.start()


func _on_pinged_timer_timeout() -> void:
	outline.visible = false
