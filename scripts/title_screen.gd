extends Node


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		MusicPlayer.play_song(MusicPlayer.Song.MENU)
	if event is InputEventMouseButton and event.is_pressed():
		MusicPlayer.play_song(MusicPlayer.Song.MENU)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
	$ButtonClick.play()

func _on_play_mouse_entered() -> void:
	$ButtonHover.play()

func _on_test_level_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/test_level.tscn")
