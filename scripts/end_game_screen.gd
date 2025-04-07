extends Node



func _ready() -> void:
	$DepthMeter/Label.text = str(EntityManager.player_stats.max_depth) + "m"
	if GlobalSignals.victory:
		$DepthMeter/Crack.visible = false
	GlobalSignals.victory = false


func _on_base_camp_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/basecamp.tscn")
