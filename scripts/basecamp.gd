extends Node

@onready var label := $Label
var player_stats: PermStats = EntityManager.player_stats


func _ready() -> void:
	label.text = str(player_stats.research)


func _on_launch_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

#Hey Austin, I copied your Title screen and injected this. I'll update the art.
