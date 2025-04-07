extends Node

signal player_health_changed(max_health: int, health: int)
signal player_moved(global_position: Vector2)
signal heal_player(heal: int)
signal use_sonar
signal research_added

var victory := false


func on_player_health_changed(max_health: int, health: int) -> void:
	player_health_changed.emit(max_health, health)
	

func on_player_moved(global_position: Vector2) -> void:
	player_moved.emit(global_position / 2)
	

func on_heal_player(heal: int) -> void:
	heal_player.emit(heal)
	

func on_use_sonar() -> void:
	use_sonar.emit()
	

func on_research_added() -> void:
	research_added.emit()
