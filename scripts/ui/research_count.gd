extends TextureRect


@onready var label := $HBoxContainer/Label
var player_stats: PermStats = EntityManager.player_stats


func _physics_process(_delta: float) -> void:
	label.text = str(player_stats.research)
