extends TextureProgressBar

@export var colors: Array[Color]


func _ready() -> void:
	GlobalSignals.player_health_changed.connect(_on_player_health_changed)
	

func _on_player_health_changed(max_health: int, health: int) -> void:
	max_value = max_health
	value = health
	var percent := value / max_value
	
	if percent >= 0.5:
		tint_progress = colors[0]
	elif percent > 0.1:
		tint_progress = colors[1]
	else:
		tint_progress = colors[2]
