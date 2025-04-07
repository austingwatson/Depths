class_name ResearchBeam 
extends Area2D

@onready var scan_beam := $ScanBeam
var resource_count := 0


func _on_area_entered(area: Area2D) -> void:
	if area is ResourcePickup:
		area.start_scan()
		scan_beam.visible = true
		resource_count += 1


func _on_area_exited(area: Area2D) -> void:
	if area is ResourcePickup:
		area.end_scan()
		resource_count -= 1
		if resource_count <= 0:
			scan_beam.visible = false
			if resource_count < 0:
				resource_count = 0
