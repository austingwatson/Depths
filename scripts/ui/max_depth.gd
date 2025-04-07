extends TextureRect

@onready var label := $Label
var player_stats := EntityManager.player_stats


func _ready() -> void:
	label.text = "max depth: " + str(player_stats.max_depth)
