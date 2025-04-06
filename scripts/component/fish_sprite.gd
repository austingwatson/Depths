class_name FishSprite
extends Sprite2D

@export var diffuse_texture: Texture2D
@export var normal_texture: Texture2D
@export var outline_texture: Texture2D
@export var visible_rect: Rect2
@export var show_time: float
@onready var outline := $Outline
@onready var pinged_timer := $PingedTimer
var on_screen := false


func _ready() -> void:
	texture.diffuse_texture = diffuse_texture
	texture.normal_texture = normal_texture
	outline.texture = outline_texture
	$VisibleOnScreenNotifier2D.rect = visible_rect
	pinged_timer.wait_time = show_time


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	on_screen = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	on_screen = false
	

func pinged() -> void:
	if on_screen:
		outline.visible = true
	else:
		print("show arrow")
	pinged_timer.start()


func _on_pinged_timer_timeout() -> void:
	outline.visible = false
