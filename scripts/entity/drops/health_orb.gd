extends Area2D

var heal := 0


func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _on_area_entered(_area: Area2D) -> void:
	GlobalSignals.on_heal_player(heal)
	queue_free()
