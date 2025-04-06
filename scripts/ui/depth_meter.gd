extends TextureRect

@onready var label := $Label


func _ready() -> void:
	GlobalSignals.player_moved.connect(_on_player_moved)


func _on_player_moved(global_position: Vector2) -> void:
	label.text = str(int(global_position.y)) + "m"
