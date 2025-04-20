extends TextureProgressBar

@onready var timer := $Timer
var hovered := false
var can_press := false


func _physics_process(_delta: float) -> void:
	if hovered:
		value = timer.wait_time - timer.time_left
	
	if can_press and Input.is_action_just_pressed("shoot"):
		EntityManager.clear()
		get_tree().change_scene_to_file("res://scenes/basecamp.tscn")


func _on_mouse_entered() -> void:
	$ButtonHover.play()
	timer.start()
	hovered = true


func _on_mouse_exited() -> void:
	timer.stop()
	hovered = false
	can_press = false
	value = 0


func _on_timer_timeout() -> void:
	can_press = true
	$ButtonReady.play()
