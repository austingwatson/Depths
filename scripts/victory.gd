extends Node

@onready var sub := $Sub_Anim
@onready var big_floater := $Big_Floater_Anim
@onready var floater := $Floater_Anim
@onready var mission_accomplished := $MissionAccomplished

func _ready() -> void:
	sub.play("sub_float")
	big_floater.play("float")
	floater.play("float")
	mission_accomplished.play("default")
	$Win.play()
	EntityManager.player_stats.add_research(100)


func _on_base_camp_button_mouse_entered() -> void:
	$ButtonHover.play()


func _on_base_camp_button_pressed() -> void:
	$ButtonClick.play()
	get_tree().change_scene_to_file("res://scenes/basecamp.tscn")
