extends Node

func _on_next_button_mouse_entered() -> void:
	$ButtonHover.play()

func _on_next_button_pressed() -> void:
	$ButtonClick.play()
	get_tree().change_scene_to_file("res://scenes/tutorial3.tscn")

func _on_back_button_mouse_entered() -> void:
	$ButtonHover.play()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
	$ButtonClick.play()
