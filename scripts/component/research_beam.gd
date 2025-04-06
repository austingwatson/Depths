class_name ResearchBeam 
extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area is ResourcePickup:
		area.start_scan()


func _on_area_exited(area: Area2D) -> void:
	if area is ResourcePickup:
		area.end_scan()


func _on_scan_timer_timeout() -> void:
	pass # Replace with function body.
