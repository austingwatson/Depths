extends TextureRect


func show_tooltip() -> void:
	$AnimationPlayer.play("change_color")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "change_color":
		queue_free()
