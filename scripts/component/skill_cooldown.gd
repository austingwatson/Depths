class_name SkillCooldown
extends Node

@export var cooldown := 0.0
@onready var timer := $Timer
var on_cooldown := false


func _ready() -> void:
	timer.wait_time = cooldown


func use() -> void:
	on_cooldown = true
	timer.start()


func _on_timer_timeout() -> void:
	on_cooldown = false
