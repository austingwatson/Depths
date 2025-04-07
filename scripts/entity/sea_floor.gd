extends Area2D


func _physics_process(_delta: float) -> void:
	global_position.x = get_viewport().get_camera_2d().global_position.x


func _on_area_entered(area: Area2D) -> void:
	print(area)
	if area is HurtBox:
		GlobalSignals.victory = true
		EntityManager.clear()
		get_tree().call_deferred("change_scene_to_file", "res://scenes/end_game_screen.tscn")
		#get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
