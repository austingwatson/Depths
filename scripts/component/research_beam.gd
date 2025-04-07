class_name ResearchBeam 
extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area is ResourcePickup:
		area.start_scan()
	#get_node("ScanBeam").self_modulate = Color8(#fbae24) "This is supposed to make the scna beam appear orange"


func _on_area_exited(area: Area2D) -> void:
	if area is ResourcePickup:
		area.end_scan()
	#get_node("ScanBeam").self_modulate = Color8(#fbae2400) "This is supposed to make it become invisible again"




func _on_scan_timer_timeout() -> void:
	pass # Replace with function body.
