extends Node

func _ready() -> void:
	$TextScroller.play("text_scroll")

func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")


func _on_skip_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/basecamp.tscn")
