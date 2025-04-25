extends Node

func _ready() -> void:
	$TextScroller.play("text_scroll")
	MusicPlayer.play_song(MusicPlayer.Song.MENU)

func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
	$ButtonClick.play()


func _on_skip_tutorial_button_pressed() -> void:
	$ButtonClick.play()
	get_tree().change_scene_to_file("res://scenes/basecamp.tscn")


func _on_tutorial_button_mouse_entered() -> void:
	$ButtonHover.play()


func _on_skip_tutorial_button_mouse_entered() -> void:
	$ButtonHover.play()
