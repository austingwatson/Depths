extends TextureRect

@onready var animation_player := $AnimationPlayer
var player_stats: PermStats = EntityManager.player_stats


func _ready() -> void:
	GlobalSignals.use_sonar.connect(on_use_sonar)
	

func on_use_sonar() -> void:
	animation_player.play("start_cooldown")
	animation_player.speed_scale = 1.0 / player_stats.sonar_cooldown
