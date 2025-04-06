extends HurtBox


func _physics_process(_delta: float) -> void:
	global_position.x = get_viewport().get_camera_2d().global_position.x
