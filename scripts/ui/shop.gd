class_name Shop
extends Control


func _on_close_pressed() -> void:
	visible = false
	$ButtonClick.play()

func _on_close_mouse_entered() -> void:
	$ButtonHover.play()
