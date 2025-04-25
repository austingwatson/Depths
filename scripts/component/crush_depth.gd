class_name CrushDepth
extends Node

@export var player: Node2D
@export var hurtBox: HurtBox
@export var first_crush_depth := 0.0
@export var second_crush_depth := 0.0
@onready var timer := $Timer
var player_stats: PermStats = EntityManager.player_stats
var crush_depth := 0.0
var shown_tooltip := false


func _ready() -> void:
	if player_stats.depth:
		crush_depth = second_crush_depth
	else:
		crush_depth = first_crush_depth


func _physics_process(_delta: float) -> void:
	if player.global_position.y / 2 > crush_depth:
		timer.paused = false
		if not shown_tooltip:
			shown_tooltip = true
			GlobalSignals.on_show_depth_tooltip()
	else:
		timer.paused = true


func _on_timer_timeout() -> void:
	hurtBox.take_damage(1)
