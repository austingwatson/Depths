extends Node

@export var sky_speed := 0.0
@onready var sky := $Sky
@onready var arm := $Arm
@onready var animation_player := $AnimationPlayer
@onready var shop := $Shop
@onready var upgraded := $Upgraded
var player_stats: PermStats = EntityManager.player_stats


func _ready() -> void:
	arm.play("default")
	MusicPlayer.play_song(MusicPlayer.Song.MENU)
	
	
func _physics_process(delta: float) -> void:
	sky.position.x -= sky_speed * delta
	if sky.position.x <= -480:
		sky.position.x = 0


func _on_launch_pressed() -> void:
	animation_player.play("launch")
	arm.stop()
	shop.visible = false
	$ButtonClick.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "launch":
		get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_open_shop_mouse_entered() -> void:
	$ButtonHover.play()


func _on_open_shop_pressed() -> void:
	shop.visible = true
	$ButtonClick.play()


func _on_launch_mouse_entered() -> void:
	$ButtonHover.play()
