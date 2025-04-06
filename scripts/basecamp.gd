extends Node

@onready var arm := $Arm
@onready var animation_player := $AnimationPlayer
var player_stats: PermStats = EntityManager.player_stats


func _ready() -> void:
	arm.play("default")


func _on_launch_pressed() -> void:
	animation_player.play("launch")
	arm.stop()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "launch":
		get_tree().change_scene_to_file("res://scenes/game.tscn")
